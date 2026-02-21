# Explain Code

Explain the attached code, file, or component clearly and at the right level of depth.

## Instructions

Provide an explanation structured as follows:

### Purpose
What this code does and why it exists in the system. Connect it to the broader architecture (ATS, PositionServer, FillSnooper, trading pipeline) where relevant.

### How It Works
Walk through the key logic. Explain non-obvious design decisions — especially anything related to:
- Latency-sensitive paths and why they are structured as they are
- RAII, ownership, or lifetime decisions
- Use of the Chassis pattern, strong typedefs, or listener/observer pattern
- Anything that deviates from the norm and why

### Key Interfaces
What does this component expose, and what does it depend on? Name the concrete types and interfaces.

### What To Watch Out For
Gotchas, invariants that must be maintained, or areas that are fragile or in the middle of migration toward the DI/service-app architecture.

### Open Questions
If anything is unclear from the code alone, list it explicitly rather than guessing.
