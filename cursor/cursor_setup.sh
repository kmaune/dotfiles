#!/usr/bin/env bash
# cursor_setup.sh
# Sets up Cursor config in dotfiles and symlinks into core worktree.
# Run once from anywhere. Safe to re-run — checks before creating.

set -euo pipefail

DOTFILES_CURSOR="$HOME/dotfiles/cursor"
CORE="$HOME/core"

# ── 1. Create dotfiles directory structure ────────────────────────────────────

echo "→ Creating dotfiles/cursor structure..."
mkdir -p "$DOTFILES_CURSOR/rules"
mkdir -p "$DOTFILES_CURSOR/commands"
mkdir -p "$DOTFILES_CURSOR/agents"
echo "  ✓ $DOTFILES_CURSOR/{rules,commands,agents}"

# ── 2. Symlink .cursor into core ──────────────────────────────────────────────

echo "→ Symlinking .cursor into core..."

if [ -e "$CORE/.cursor" ] && [ ! -L "$CORE/.cursor" ]; then
  echo "  ✗ $CORE/.cursor exists and is NOT a symlink — move or remove it first"
  exit 1
fi

if [ -L "$CORE/.cursor" ]; then
  echo "  ~ $CORE/.cursor symlink already exists, skipping"
else
  ln -s "$DOTFILES_CURSOR" "$CORE/.cursor"
  echo "  ✓ $CORE/.cursor -> $DOTFILES_CURSOR"
fi

# ── 3. Symlink existing worktrees ─────────────────────────────────────────────

echo "→ Checking existing worktrees for missing .cursor symlinks..."

# Get all worktree paths except core itself
git -C "$CORE" worktree list --porcelain \
  | grep "^worktree " \
  | awk '{print $2}' \
  | grep -v "^$CORE$" \
  | while read -r wt_path; do
      if [ -L "$wt_path/.cursor" ]; then
        echo "  ~ $wt_path/.cursor already symlinked, skipping"
      elif [ -e "$wt_path/.cursor" ]; then
        echo "  ✗ $wt_path/.cursor exists but is not a symlink — skipping (manual review needed)"
      else
        ln -s "$DOTFILES_CURSOR" "$wt_path/.cursor"
        echo "  ✓ $wt_path/.cursor -> $DOTFILES_CURSOR"
      fi
    done

# ── 4. Summary ────────────────────────────────────────────────────────────────

echo ""
echo "Setup complete."
echo ""
echo "Next steps:"
echo "  1. Copy your rule, command, and agent files into:"
echo "       $DOTFILES_CURSOR/rules/"
echo "       $DOTFILES_CURSOR/commands/"
echo "       $DOTFILES_CURSOR/agents/"
echo "  2. Commit dotfiles:    cd ~/dotfiles && git add cursor/ && git commit -m 'Add Cursor config'"
echo "  3. New worktrees:      ln -s ~/dotfiles/cursor <worktree>/.cursor"
