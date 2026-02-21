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

# ── 3. Add gwt function to shell rc ──────────────────────────────────────────

GWT_FUNC=$(cat <<'EOF'

# Cursor-aware git worktree add
# Usage: gwt <folder-name> <branch>
# Example: gwt feature_1 feature/my-feature
function gwt() {
  if [ -z "${1:-}" ] || [ -z "${2:-}" ]; then
    echo "Usage: gwt <folder-name> <branch>"
    return 1
  fi

  local worktree_path="$HOME/$1"
  local branch="$2"

  git -C "$HOME/core" worktree add "$worktree_path" "$branch"

  if [ -e "$worktree_path/.cursor" ] && [ ! -L "$worktree_path/.cursor" ]; then
    echo "Warning: $worktree_path/.cursor exists and is not a symlink — skipping symlink"
    return 1
  fi

  ln -sf "$HOME/dotfiles/cursor" "$worktree_path/.cursor"
  echo "✓ Worktree created: $worktree_path"
  echo "✓ .cursor symlinked: $worktree_path/.cursor -> $HOME/dotfiles/cursor"
}
EOF
)

# Detect shell rc file
if [ -f "$HOME/.zshrc" ]; then
  RC_FILE="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
  RC_FILE="$HOME/.bashrc"
else
  echo "  ✗ Could not detect .zshrc or .bashrc — add gwt manually"
  exit 1
fi

if grep -q "function gwt" "$RC_FILE"; then
  echo "→ gwt function already exists in $RC_FILE, skipping"
else
  echo "$GWT_FUNC" >> "$RC_FILE"
  echo "→ gwt function added to $RC_FILE"
fi

# ── 4. Symlink existing worktrees ─────────────────────────────────────────────

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

# ── 5. Summary ────────────────────────────────────────────────────────────────

echo ""
echo "Setup complete."
echo ""
echo "Next steps:"
echo "  1. Copy your rule, command, and agent files into:"
echo "       $DOTFILES_CURSOR/rules/"
echo "       $DOTFILES_CURSOR/commands/"
echo "       $DOTFILES_CURSOR/agents/"
echo "  2. Reload your shell:  source $RC_FILE"
echo "  3. Commit dotfiles:    cd ~/dotfiles && git add cursor/ && git commit -m 'Add Cursor config'"
echo "  4. Future worktrees:   gwt <folder-name> <branch>"
