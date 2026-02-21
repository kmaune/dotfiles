#!/bin/bash
# Claude Code setup script

echo "Setting up Claude Code..."

# Handle existing ~/.claude
if [ -L ~/.claude ]; then
    # Already a symlink — remove and recreate
    rm ~/.claude
elif [ -d ~/.claude ]; then
    # Real directory — back it up (may contain runtime data worth keeping)
    echo "⚠️  Backing up existing ~/.claude to ~/.claude.backup"
    mv ~/.claude ~/.claude.backup
fi

# Symlink the whole directory
ln -sf ~/dotfiles/claude ~/.claude
echo "✓ ~/.claude → ~/dotfiles/claude"

# Verify
if command -v claude &> /dev/null; then
    echo "✓ Claude Code found: $(claude --version 2>/dev/null || echo 'version unknown')"
else
    echo "⚠️  Claude Code not found. Install with:"
    echo "   npm install -g @anthropic-ai/claude-code"
fi

echo ""
echo "Done. Run 'claude' to start a session."
