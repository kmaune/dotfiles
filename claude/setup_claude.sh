#!/bin/bash
# Claude Code setup script

echo "Setting up Claude Code AI assistant..."

# Create symlinks for configuration files
rm -f ~/.claude/settings.json ~/.claude/CLAUDE.md ~/.claude/.claudeignore
ln -sf ~/dotfiles/claude/settings.json ~/.claude/settings.json
ln -sf ~/dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md  
ln -sf ~/dotfiles/claude/.claudeignore ~/.claude/.claudeignore
echo "✓ Claude Code configuration files linked"

# Create symlinks for agents and commands directories
rm -rf ~/.claude/agents ~/.claude/commands
ln -sf ~/dotfiles/claude/agents ~/.claude/agents
ln -sf ~/dotfiles/claude/commands ~/.claude/commands
echo "✓ Claude Code agents and commands linked"

# Set basic configuration via CLI
if command -v claude &> /dev/null; then
    echo "✓ Claude Code command available"
    
    # Check current configuration
    echo "Current Claude Code configuration:"
    claude config list
    echo "✓ Configuration managed via settings.json"
else
    echo "⚠️  Claude Code not found. Install with:"
    echo "   npm install -g @anthropic-ai/claude-code"
    echo "   # or"
    echo "   brew install claude-code"
fi

echo "✓ Claude Code setup complete!"
echo ""
echo "Usage:"
echo "  claude                  # Start Claude Code session"
echo "  claude-sonnet          # Use Claude 3.5 Sonnet (fast)"
echo "  claude-opus            # Use Claude 3 Opus (thorough)"
echo "  claude-auto            # Skip permission prompts"
echo "  claude-config          # Edit configuration"
echo "  claude-agents          # Manage agents"
echo ""
echo "Available agents:"
echo "  cpp-code-reviewer      # C++ code review specialist"
echo "  cpp-implementer        # Direct C++ implementation"
echo "  cpp-mentor             # C++ learning and guidance"
echo "  cpp-performance-expert # C++ performance optimization"
echo "  git-workflow-helper    # Git operations and workflows"
echo "  hft-code-reviewer      # HFT and trading system reviews"
echo "  hft-systems-architect  # Ultra-low latency system design"
echo "  principal-code-reviewer # General code review"
echo "  principal-systems-architect # High-level architecture"