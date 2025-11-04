# Claude Code Integration

Claude Code AI assistant integration for the dotfiles repository, providing specialized agents and commands for C++ development.

## Quick Start

```bash
# Install and setup 
./install.sh          # or ./safe_install.sh

# Start Claude Code
claude                 # Start interactive session
claude --help         # Show available options
```

## Features

### 🤖 Specialized Agents (9 total)
- **cpp-code-reviewer** - C++ code review specialist  
- **cpp-implementer** - Direct C++ implementation
- **cpp-mentor** - C++ learning and guidance
- **cpp-performance-expert** - C++ performance optimization
- **git-workflow-helper** - Git operations and workflows
- **hft-code-reviewer** - HFT and trading system reviews
- **hft-systems-architect** - Low-latency system design
- **principal-code-reviewer** - General code review
- **principal-systems-architect** - High-level architecture

### ⚡ Custom Commands (4 total)
- **git-pr-review** - Comprehensive PR review workflow
- **new-cpp-project** - Scaffold new C++ project
- **performance-audit** - Analyze code for performance issues
- **setup-benchmarks** - Create performance benchmarks

### 🔧 Configuration
- **settings.json** - Core Claude Code settings with C++ optimizations
- **CLAUDE.md** - Global context for C++ development
- **.claudeignore** - Ignore patterns for build artifacts and large files

## Installation

### Prerequisites
```bash
# Install Claude Code
npm install -g @anthropic-ai/claude-code
# or
brew install claude-code
```

### Setup
```bash
# Automatic setup (recommended)
./install.sh

# Manual setup
~/dotfiles/claude/setup_claude.sh
```

## Usage

### Model Selection
```bash
claude --model claude-3-5-sonnet-20241022  # Claude 3.5 Sonnet (fast, recommended)
claude --model claude-3-opus-20240229      # Claude 3 Opus (thorough, slower)
claude --no-confirm                        # Skip permission prompts for automation
```

### Agent Management
```bash
ls ~/.claude/agents/                     # List available agents
nvim ~/.claude/agents/<agent>.md         # Edit specific agent

# Example: Edit the C++ code reviewer
nvim ~/.claude/agents/cpp-code-reviewer.md
```

### Command Management  
```bash
ls ~/.claude/commands/                      # List available commands
nvim ~/.claude/commands/<command>.md        # Edit specific command

# Example: Edit the performance audit command
nvim ~/.claude/commands/performance-audit.md
```

### Configuration
```bash
# Edit main settings
nvim ~/dotfiles/claude/settings.json

# Edit global context
nvim ~/dotfiles/claude/CLAUDE.md

# Edit ignore patterns
nvim ~/dotfiles/claude/.claudeignore
```

## Directory Structure

```
claude/
├── README.md                 # This file
├── setup_claude.sh          # Setup script
├── settings.json            # Core configuration
├── CLAUDE.md               # Global context for C++ development
├── .claudeignore           # Ignore patterns
├── agents/                 # Specialized AI agents (9 total)
│   ├── cpp-code-reviewer.md
│   ├── cpp-implementer.md
│   ├── cpp-mentor.md
│   ├── cpp-performance-expert.md
│   ├── git-workflow-helper.md
│   ├── hft-code-reviewer.md
│   ├── hft-systems-architect.md
│   ├── principal-code-reviewer.md
│   └── principal-systems-architect.md
└── commands/               # Custom workflow commands (4 total)
    ├── git-pr-review.md
    ├── new-cpp-project.md
    ├── performance-audit.md
    └── setup-benchmarks.md
```

## Adding New Agents

1. Create a new markdown file in `agents/` directory:
```bash
nvim ~/.claude/agents/my-new-agent.md
```

2. Use this template:
```markdown
---
name: my-new-agent
description: Brief description of what this agent does
tools: file_read, file_write, bash, grep, git
---

# Agent Instructions

Detailed instructions for the agent...
```

3. The agent will be automatically available in Claude Code

## Adding New Commands

1. Create a new markdown file in `commands/` directory:
```bash
nvim ~/.claude/commands/my-command.md
```

2. Use this template:
```markdown
---
name: my-command
description: Brief description of the command
---

# Command Instructions

Instructions for what the command should do...

Use $ARGUMENTS to access command arguments.
```

3. Use the command with `/my-command` in Claude Code

## Best Practices

### Agent Development
- **Single Purpose**: Each agent should have a focused, specific role
- **Clear Tools**: Only request the tools the agent actually needs
- **Detailed Instructions**: Provide comprehensive guidance for consistent behavior
- **Performance Focus**: For performance-critical agents, emphasize efficiency and best practices

### Command Development  
- **Workflow Oriented**: Commands should automate common development workflows
- **Parameterized**: Use $ARGUMENTS for flexibility
- **Error Handling**: Include guidance for handling common error scenarios
- **Documentation**: Clearly explain what the command does and how to use it

### Configuration Management
- **Version Control**: All configuration is tracked in git
- **No Secrets**: Never commit API keys or sensitive data
- **Ignore Patterns**: Keep .claudeignore up to date with build artifacts
- **Context Aware**: Update CLAUDE.md for project-specific guidance

## Troubleshooting

### Claude Code Not Found
```bash
# Install Claude Code
npm install -g @anthropic-ai/claude-code
# or
brew install claude-code
```

### Agents Not Loading
```bash
# Check symlinks
ls -la ~/.claude/agents/
ls -la ~/.claude/commands/

# Re-run setup
~/dotfiles/claude/setup_claude.sh
```

### Configuration Issues
```bash
# Check current config
claude config list

# Reset to defaults
rm ~/.claude/settings.json
~/dotfiles/claude/setup_claude.sh
```

### Permission Issues
```bash
# Check file permissions
ls -la ~/dotfiles/claude/

# Make setup script executable
chmod +x ~/dotfiles/claude/setup_claude.sh
```

## Integration with Other Tools

### With Aider
- Both tools can coexist and complement each other
- Aider for local models, Claude Code for cloud models
- Both use similar patterns for configuration and setup

### With Git
- `git-workflow-helper` agent handles Git operations
- `git-pr-review` command for comprehensive PR reviews
- Hooks can be configured for automated workflows

### With Build Systems
- Settings ignore common build artifacts
- Performance focus in global context
- Benchmark setup commands for CMake projects

## Advanced Usage

### Project-Specific Settings
```bash
# Create project-specific .claude/settings.json
mkdir .claude
cp ~/dotfiles/claude/settings.json .claude/
# Edit for project needs
```

### Automation Scripts
```bash
# Use --no-confirm for CI/CD integration
claude --no-confirm --task "review changes since main"
```

### Custom Workflows
```bash
# Chain commands and agents for complex workflows
claude /performance-audit
# Then manually invoke cpp-performance-expert agent
```