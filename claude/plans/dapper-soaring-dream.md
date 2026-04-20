# Step 8 — Logging & Monitoring

## Context

Steps 1–7 are complete (87 unit tests passing). The bot connects, quotes, fills, manages
inventory, and shuts down cleanly. Step 8 adds the observability layer: structured logging for
every state change, OFI imbalance detection, a periodic status line, and an offline PnL
analysis script. None of this changes core strategy logic — it is purely monitoring.

**What already exists (don't duplicate):**
- Fill logging: `inventory.py` logs `order_id, side, action, count, yes_price, net_position, avg_entry, at_limit, near_limit` at INFO on every fill. ✅
- Quote placement: `executor.py` logs `order_id, yes_price, count` at INFO on every bid/ask placed. ✅
- Quote suppression: executor logs `cancel_all` at INFO; cancel-during-refresh at **DEBUG** (gap — upgrade to INFO per spec).
- Bot logs mid-price, variance, kill switch, reconciliation. ✅

**Gaps to close:**
1. Cancel-during-refresh is DEBUG — upgrade to INFO (structured logging requirement).
2. OFI monitoring — not implemented.
3. Periodic status line — not implemented (console output requirement).
4. Offline PnL analysis script — not implemented.

---

## 🟡 Plumbing Decisions

**Decision 1 — OFI uses mid-price direction, not depth changes**
- LOBState only exposes best prices (`yes_bid`, `yes_ask`, `no_bid`, `no_ask`, `mid_price`) — no
  quantity/depth data. True depth-based OFI requires quantity deltas.
- Choice: rolling window of signed mid-price changes as a proxy. OFI ∈ [-1, +1] = net directional
  pressure over the window. Positive = buy-side dominance; negative = sell-side.
- Rationale: sufficient for Stage 1 flagging. Stage 2 can replace with a depth-aware signal if
  the LOB is extended to track quantities. No other component depends on the OFI formula.

**Decision 2 — OFI lives in `src/strategy/ofi.py`**
- Borderline core vs. strategy. It's a market signal that informs strategy (Stage 2 use).
  Keeps it adjacent to `variance.py` and `inventory.py` (other market signals).
- Alternative: `src/core/monitor.py`. Rejected — monitoring is downstream of strategy.

**Decision 3 — PnL attribution is offline-only (script, not runtime accumulation)**
- The bot already logs all data needed to compute PnL offline (fills with avg_entry, yes_price,
  net_position). Adding runtime PnL accumulators would duplicate data with no operational benefit
  at Stage 1 scale.
- The offline script reconstructs position state from log lines and computes realized PnL for
  closing fills. Attribution: realized gain = spread capture proxy; realized loss = drift proxy.
- Unrealized PnL is estimated from last known mid and avg_entry in the log.

**Decision 4 — Status log is time-based (not tick-based)**
- Every `STATUS_LOG_INTERVAL` seconds (default 30s) via `time.monotonic()` in `_on_update`.
- Alternative: every N updates. Rejected — update rate is variable (quiet markets → rare updates
  → silent status log; active markets → log spam).
- Last bid/ask are tracked in runner as `self._last_bid` / `self._last_ask` (not exposed from
  TradeSender) — avoids adding properties to executor for monitoring purposes only.

---

## Files to Create

### `src/strategy/ofi.py`

```python
class OFIMonitor:
    def __init__(self, window: int = 50, imbalance_threshold: float = 0.6) -> None
    def update(self, mid_price: float) -> None
        # Appends sign(mid_price - prev_mid) to rolling deque(maxlen=window)
    def ofi_ratio(self) -> Optional[float]
        # sum(changes) / window; None until window is full
    def is_imbalanced(self) -> bool
        # abs(ofi_ratio()) >= threshold
    @property
    def observations(self) -> int
```

### `tests/test_ofi.py` (8 tests)

| Test | Assertion |
|---|---|
| `test_ofi_returns_none_before_any_updates` | no updates → `ofi_ratio() is None` |
| `test_ofi_returns_none_until_window_full` | `window-1` updates → still None |
| `test_ofi_positive_for_rising_mid` | 50 strictly rising prices → `ofi_ratio() == 1.0` |
| `test_ofi_negative_for_falling_mid` | 50 strictly falling → `ofi_ratio() == -1.0` |
| `test_ofi_zero_for_flat_mid` | 50 identical prices → `ofi_ratio() == 0.0` |
| `test_is_imbalanced_above_threshold` | ratio=1.0, threshold=0.6 → `True` |
| `test_is_imbalanced_false_below_threshold` | ratio=0.4, threshold=0.6 → `False` |
| `test_rolling_window_evicts_old_observations` | fill with 25 up then 25 down → ratio=0.0 |

### `scripts/analyze_pnl.py` (~80 lines)

```
Usage: python scripts/analyze_pnl.py --log FILE [--since ISO_TIMESTAMP] [--until ISO_TIMESTAMP]

Parses fill log lines (matched by regex against inventory.py's log format):
  Fill: order_id=... side=... action=... count=... yes_price=... | net_position=... avg_entry=...

Algorithm:
1. Parse and timestamp-filter matching lines.
2. Replay fills sequentially, tracking (position, avg_entry) using the same logic as
   InventoryManager: add to position → VWAP update; reduce position → avg stays; cross zero → reset.
3. On each REDUCING fill: compute realized_pnl = (yes_price - avg_entry_before) × count × sign(position_before)
4. Accumulate: total_fills, total_volume, total_realized_pnl, pnl_positive_fills, pnl_negative_fills.
5. At end: report open position, estimated unrealized PnL (last yes_price from fill log as proxy mid).
6. Attribution: realized gain (>0 fills) → spread capture proxy; realized loss (<0 fills) → drift proxy.

Output (printed, not logged):
  === PnL Summary [since ... until ...] ===
  Fills: N   Volume: M contracts
  Realized PnL: +X cents  (gain: +G | loss: -L)
  Open position: Q contracts @ Y.Y avg entry
  Unrealized PnL (est): ±Z cents
  Spread capture proxy: +G cents
  Inventory drift proxy: -L cents
```

---

## Files to Modify

### `src/config.py` — Add monitoring constants (after VARIANCE_WINDOW)

```python
# ─── Monitoring ───────────────────────────────────────────────────────────────

# OFI rolling window (number of mid-price ticks to aggregate).
OFI_WINDOW: int = int(os.environ.get("OFI_WINDOW", "50"))

# OFI ratio threshold (abs) above which an imbalance is flagged.
OFI_IMBALANCE_THRESHOLD: float = float(os.environ.get("OFI_IMBALANCE_THRESHOLD", "0.6"))

# How often (seconds) to emit the STATUS log line.
STATUS_LOG_INTERVAL: float = float(os.environ.get("STATUS_LOG_INTERVAL", "30"))
```

### `src/execution/executor.py` — Upgrade cancel-during-refresh from DEBUG → INFO

```python
# Line 146 — change logger.debug → logger.info
logger.info("Cancelling %d existing order(s): %s", len(order_ids), order_ids)
```

### `src/core/runner.py` — Four targeted changes

**1. Imports:**
```python
import time
from src.strategy.ofi import OFIMonitor
```

**2. `__init__`: Add OFI monitor, start time, and last-quote trackers**
```python
self._ofi_monitor = OFIMonitor(
    window=cfg.OFI_WINDOW,
    imbalance_threshold=cfg.OFI_IMBALANCE_THRESHOLD,
)
self._start_time: float = time.monotonic()
self._last_status_log: float = 0.0   # forces immediate first status log
self._last_bid: Optional[int] = None
self._last_ask: Optional[int] = None
```

**3. `_on_update`: Wire OFI, track quotes, add periodic status log**

After `self._variance.update(state.mid_price)` and before the cold-start guard:
```python
if state.mid_price is not None:
    self._ofi_monitor.update(float(state.mid_price))
    if self._ofi_monitor.is_imbalanced():
        logger.info(
            "OFI imbalance detected — ratio=%.2f (window=%d)",
            self._ofi_monitor.ofi_ratio(), cfg.OFI_WINDOW,
        )
```

After `await self._trade_sender.refresh_quotes(...)`:
```python
self._last_bid = quote.bid_price
self._last_ask = quote.ask_price
```

At the end of `_on_update`, before returning:
```python
now = time.monotonic()
if now - self._last_status_log >= cfg.STATUS_LOG_INTERVAL:
    self._log_status(state)
    self._last_status_log = now
```

**4. Add `_log_status` method:**
```python
def _log_status(self, state: LOBState) -> None:
    net_pos = self._inventory.net_position
    avg_entry = self._inventory.avg_entry_price
    unrealized = None
    if net_pos != 0 and state.mid_price is not None:
        unrealized = round((state.mid_price - avg_entry) * net_pos)
    ofi = self._ofi_monitor.ofi_ratio()
    logger.info(
        "STATUS bid=%s ask=%s mid=%s | net_pos=%d avg_entry=%.1f "
        "unrealized=%s | ofi=%s | updates=%d uptime=%.0fs",
        self._last_bid, self._last_ask, state.mid_price,
        net_pos, avg_entry,
        f"{unrealized:+d}c" if unrealized is not None else "n/a",
        f"{ofi:+.2f}" if ofi is not None else "n/a",
        self._update_count,
        time.monotonic() - self._start_time,
    )
```

---

## Scope Boundaries

| In scope | Out of scope |
|---|---|
| OFIMonitor (mid-price proxy, rolling window) | Depth-based OFI (no quantity data in LOBState) |
| Periodic STATUS log line | Real-time dashboard or curses UI |
| Offline `analyze_pnl.py` script | Database storage, Prometheus metrics |
| Upgrade cancel-during-refresh to INFO | Changes to core strategy logic |
| 8 OFI unit tests | Tests for analyze_pnl.py (standalone script, not a module) |

---

## Acceptance Criteria

- [ ] `tests/test_ofi.py`: 8 tests, all green
- [ ] No regressions: 87 prior tests still pass (95 total)
- [ ] Cancel-during-refresh logs at INFO (not DEBUG)
- [ ] STATUS log line appears in bot output every ~30 seconds
- [ ] OFI imbalance log fires when ratio exceeds threshold (verifiable by feeding >60% directional mid-prices manually)
- [ ] `scripts/analyze_pnl.py --help` works; script produces correct output on sample log

---

## Doc Updates (complete before stopping)

- [ ] Mark Step 8 ✅ Complete in `docs/strategy/02_phase1_implementation.md`
- [ ] Update Current Status in `CLAUDE.md` (Stage 1 MVP complete — all 8 steps done)
- [ ] Produce `docs/checkpoints/step8_handoff.md`
