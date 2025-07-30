# Dotfiles

My personal configuration files for various tools and development environments.

## Quick Setup

```bash
git clone --recurse-submodules https://github.com/kmaune/dotfiles.git ~/dotfiles
cd ~/dotfiles
./safe_install.sh
```

## What's Included

- **Shell configuration**: Enhanced zsh with custom prompt, history settings, and aliases
- **Vim**: Complete vim setup with plugins, color scheme, and key mappings
- **Neovim**: Modern Neovim configuration based on kickstart-modular with LSP, completion, and AI tools
- **Tmux**: Terminal multiplexer with custom themes and key bindings
- **Git**: Global git configuration and aliases
- **Aider**: AI pair programming assistant with hybrid local/cloud model support
- **Claude Code**: AI assistant with 9 specialized agents for C++ development
- **Scripts**: Utility scripts for development workflows including HTTPS-enabled OpenWebUI (as git submodule)
- **Conda environments**: Predefined environments for development work
- **Homebrew packages**: System package management with backup/restore functionality

## Installation Scripts

This repo includes two installation scripts for different use cases:

### safe_install.sh (Recommended)

**Use this script when:**
- Setting up on an existing system with potential dotfiles
- You're unsure what configurations already exist
- You want to preserve existing configs as backups
- You want interactive setup options

**What it does:**
- ✅ Backs up existing files (adds `.backup` extension)
- ✅ Interactive conda environment setup
- ✅ Interactive Homebrew package setup
- ✅ Detailed feedback on what's being changed
- ✅ Safe for existing systems

```bash
./safe_install.sh
```

### install.sh (Fast & Clean)

**Use this script when:**
- Fresh system setup (new OS, new user account)
- You want to completely replace existing dotfiles
- Automated environments (CI/CD, containers)
- You're certain you don't need existing configs

**What it does:**
- ⚠️ Directly replaces existing files (no backups)
- ⚠️ Runs automatically with no prompts for most things
- ✅ Fast and straightforward
- ⚠️ Risk of data loss

```bash
./install.sh
```

## Directory Structure

```
~/dotfiles/
├── aider/                   # Aider AI coding assistant configuration
│   ├── aider.conf.yml      # Main Aider configuration
│   ├── aiderignore         # Files/patterns for Aider to ignore
│   ├── setup_aider.sh      # Aider setup script
│   └── README.md           # Aider-specific documentation
├── claude/                  # Claude Code AI assistant configuration
│   ├── agents/             # Specialized AI agents (9 total)
│   ├── commands/           # Custom workflow commands (4 total)
│   ├── settings.json       # Claude Code configuration
│   ├── CLAUDE.md          # Global context for C++ development
│   ├── .claudeignore      # Files/patterns for Claude to ignore
│   ├── setup_claude.sh    # Claude Code setup script
│   └── README.md          # Claude Code documentation
├── envs/                    # Conda environment definitions
│   ├── ai_env.yml          # AI/ML development environment
│   ├── base.yml            # Base development environment
│   └── export_env.sh       # Helper script for exporting environments
├── git/                     # Git configuration
│   └── gitconfig           # Global git settings
├── homebrew/                # Homebrew package management
│   ├── backup_brew.sh      # Homebrew backup/restore script
│   ├── Brewfile           # Main package list
│   ├── Brewfile.personal  # Personal packages (git-ignored)
│   └── README.md           # Homebrew-specific documentation
├── shell/                   # Shell configurations
│   ├── zshrc               # Zsh configuration
│   └── bash_profile        # Bash configuration
├── tmux/                    # Tmux configuration and themes
│   ├── tmux.conf           # Main tmux configuration
│   └── themes/             # Tmux color themes (git submodules)
├── vim/                     # Vim configuration
│   ├── vimrc               # Vim configuration
│   └── colors/             # Custom color schemes
├── nvim/                    # Neovim configuration (git submodule)
│   ├── init.lua            # Neovim entry point
│   ├── lua/                # Lua configuration modules
│   └── README.md           # Neovim-specific documentation
├── scripts/                 # Utility scripts (git submodule)
│   ├── openwebui/          # OpenWebUI with HTTPS and mobile voice mode support
│   └── *.sh                # Various utility scripts
├── ssh/                     # SSH configuration management
│   ├── config              # SSH client configuration
│   ├── setup_ssh.sh        # SSH setup script
│   ├── sshd_config.d/      # SSH server configuration
│   └── README.md           # SSH-specific documentation
├── install.sh              # Fast installation script
├── safe_install.sh         # Safe installation script (recommended)
└── README.md               # This file
```

## Aider AI Coding Assistant

The `aider/` directory provides a complete AI pair programming setup with hybrid local/cloud model support:

- **Local Ollama models**: Fast, private models for routine development
- **Cloud OpenRouter models**: Reliable models for when local ones struggle
- **Smart aliases**: Easy switching between different model types
- **Security-conscious**: Sensitive files automatically ignored

### Quick Start with Aider

```bash
# Fast local model for exploration
aider-quick

# Reliable cloud model when local struggles  
aider-deepseek

# Advanced reasoning for complex problems
aider-r1

# See all available models
aider-models
```

For detailed Aider configuration and usage, see `aider/README.md`.

## Working with Scripts

The `scripts/` directory is a git submodule pointing to a separate repository. This allows you to:

1. **Edit scripts locally**: Make changes in `~/dotfiles/scripts/`
2. **Push to scripts repo**: Commit and push changes directly to the scripts repository
3. **Update dotfiles reference**: Update the dotfiles repo to point to new script versions

### OpenWebUI with HTTPS

The scripts include a complete OpenWebUI setup with HTTPS support for mobile voice mode:

- **HTTPS Access**: Secure connection enables mobile browser voice input
- **Automated Certificates**: Tailscale-generated SSL certificates with auto-renewal
- **Service Management**: Start, stop, and monitor OpenWebUI stack
- **Mobile Voice Mode**: Dictate messages using your phone's microphone

For detailed setup and usage, see `scripts/openwebui/README.md`.

### Updating Scripts

```bash
# Edit scripts
cd ~/dotfiles/scripts
vim some_script.sh
git add .
git commit -m "Update script"
git push

# Update dotfiles to reference new script version
cd ~/dotfiles
git add scripts
git commit -m "Update scripts submodule"
git push
```

## Working with Neovim Configuration

The `nvim/` directory is also a git submodule, containing a fork of [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim). This setup allows you to:

1. **Customize your config**: Make personal changes to Neovim configuration
2. **Stay current with upstream**: Pull improvements from the original kickstart project
3. **Maintain version control**: Track exactly which version of the config you're using

### Updating Neovim Configuration

```bash
# Make personal changes
cd ~/dotfiles/nvim
vim lua/kmaune/plugins/new_plugin.lua
git add .
git commit -m "Add new plugin"
git push

# Pull upstream improvements (optional)
git fetch upstream
git merge upstream/main
git push

# Update dotfiles to reference new version
cd ~/dotfiles
git add nvim
git commit -m "Update neovim config"
git push
```

## Conda Environments

The `envs/` directory contains conda environment definitions:

- **base.yml**: Core development environment with essential tools
- **ai_env.yml**: Machine learning and AI development environment
- **export_env.sh**: Helper script for exporting existing environments

### Managing Environments

```bash
# Create environment from definition
conda env create -f envs/ai_env.yml

# Export current environment
cd envs
./export_env.sh my-custom-env

# Update existing environment
conda env update -f envs/base.yml
```

## Homebrew Package Management

The `homebrew/` directory provides complete package management with backup/restore functionality:

- **Brewfile**: Main packages tracked in git (shared across machines)
- **Brewfile.personal**: Personal/work-specific packages (git-ignored)
- **backup_brew.sh**: Management script for all Homebrew operations

### Managing Packages

```bash
# Export current packages to Brewfile
~/dotfiles/homebrew/backup_brew.sh export

# Install packages from Brewfile
~/dotfiles/homebrew/backup_brew.sh install

# Create personal package list
~/dotfiles/homebrew/backup_brew.sh personal

# Check status and updates
~/dotfiles/homebrew/backup_brew.sh status

# Update all packages
~/dotfiles/homebrew/backup_brew.sh update
```

## SSH Configuration

The `ssh/` directory provides secure SSH setup with Tailscale integration:

- **Hardened SSH server configuration** with security best practices
- **Modular configuration** that works with macOS system defaults
- **Public/private split** - generic configs in git, sensitive details git-ignored

### SSH Setup

```bash
# Initial setup (done via install scripts)
~/dotfiles/ssh/setup_ssh.sh

# Edit local settings
nano ~/dotfiles/ssh/sshd_config.d/999-local.conf

# Apply changes
~/dotfiles/ssh/setup_ssh.sh
```

## Claude Code Integration

Your dotfiles include a comprehensive Claude Code setup that provides AI-powered development assistance with specialized agents and custom workflows. This transforms Claude Code from a general assistant into a C++/HFT development partner.

## Overview

The `.claude/` directory provides Claude Code with project-specific context, specialized agents, custom commands, and configuration. This structure enables:

- **Intelligent code understanding** through project context
- **Specialized assistance** via domain-specific agents  
- **Custom workflows** through reusable commands
- **Optimized performance** through tailored configuration

## Folder Structure

```
.claude/
├── config.yaml         # Claude Code configuration
├── .claudeignore        # Files/patterns to exclude
├── agents/             # Specialized AI assistants
├── commands/           # Reusable workflow commands
└── CLAUDE.md           # Project context document
```

## 📁 `agents/` Directory

**Purpose:** Contains specialized AI agents with domain expertise for specific tasks.

**How Claude Code Uses It:**
- Automatically suggests relevant agents based on your current task
- Enables `@agent-name` invocation for specialized assistance
- Provides deep domain knowledge beyond general programming help

**Current Agents:**

### `cpp-performance-expert.md`
- **When used:** Performance optimization, profiling analysis, memory management
- **Expertise:** Cache optimization, SIMD, lock-free programming, compiler tuning
- **Example:** "Optimize this hot path for minimal latency"

### `cpp-mentor.md` 
- **When used:** Learning C++, design reviews, best practices guidance
- **Expertise:** Modern C++ idioms, design patterns, code architecture
- **Example:** "Review this class design for maintainability"

### `hft-systems-architect.md`
- **When used:** High-frequency trading system design and architecture
- **Expertise:** Ultra-low latency systems, market data processing, risk management
- **Example:** "Design a market data feed handler"

### `cpp-code-reviewer.md`
- **When used:** Code reviews with C++ focus
- **Expertise:** C++ best practices, memory safety, performance implications
- **Example:** Pull request reviews, code quality assessment

### `principal-code-reviewer.md`
- **When used:** General code reviews across languages
- **Expertise:** Software engineering principles, architecture patterns
- **Example:** Multi-language project reviews

### `hft-code-reviewer.md`
- **When used:** HFT-specific code reviews
- **Expertise:** Trading system patterns, latency optimization, risk controls
- **Example:** Trading algorithm reviews

## 📁 `commands/` Directory

**Purpose:** Reusable workflow commands that automate common development tasks.

**How Claude Code Uses It:**
- Enables `/command-name` execution for complex workflows
- Provides step-by-step guidance for project setup and maintenance
- Automates repetitive tasks with consistent patterns

**Current Commands:**

### `git-pr-review.md`
- **Usage:** `/git-pr-review`
- **Function:** Automated pull request review workflow
- **Features:** Quality gates, security scanning, team coordination
- **Example:** Comprehensive PR analysis with multiple specialist agents

### `new-cpp-project.md`
- **Usage:** `/new-cpp-project`
- **Function:** Scaffold modern C++ projects with best practices
- **Features:** CMake setup, testing framework, benchmarking, CI/CD
- **Example:** Creates complete project structure with documentation

### `performance-audit.md`
- **Usage:** `/performance-audit`
- **Function:** Systematic performance analysis and optimization
- **Features:** Profiling setup, bottleneck identification, optimization recommendations
- **Example:** End-to-end performance improvement workflow

### `setup-benchmarks.md`
- **Usage:** `/setup-benchmarks`
- **Function:** Add comprehensive benchmarking to existing projects
- **Features:** Google Benchmark integration, performance tracking
- **Example:** Automated benchmark suite creation

## 📁 Configuration Files

### `config.yaml`
**Purpose:** Global and project-specific Claude Code settings.

**Key Configurations:**
- **Model preferences:** Claude Sonnet 4 with fallback options
- **Agent coordination:** Auto-selection and parallel processing
- **Tool permissions:** File operations, git integration, bash access
- **Performance settings:** Memory limits, concurrent operations
- **Workflow automation:** Testing integration, commit patterns

### `.claudeignore`
**Purpose:** Exclude files/patterns from Claude Code analysis.

**Common Exclusions:**
- Build artifacts (`build/`, `dist/`, `*.o`)
- Dependencies (`node_modules/`, `vendor/`)
- Large data files (`*.csv`, `*.db`)
- Security-sensitive files (`*.key`, `.env`)
- Generated documentation (`docs/_build/`)

### `CLAUDE.md`
**Purpose:** Project-specific context and documentation for Claude Code.

**Typical Contents:**
- Project architecture overview
- Build and deployment instructions
- Performance requirements and constraints
- Code style and contribution guidelines
- Domain-specific terminology and concepts

## 🔄 How Claude Code Uses These Folders

### Automatic Agent Selection
Claude Code analyzes your current task and suggests appropriate agents:
```bash
# Working on performance optimization
claude code "optimize this function" 
# → Automatically suggests @cpp-performance-expert

# Reviewing a pull request
claude code "review this PR"
# → Suggests @cpp-code-reviewer or @hft-code-reviewer based on context
```

### Command Workflows
Commands provide guided, multi-step workflows:
```bash
claude code "/new-cpp-project trading-engine"
# → Walks through project setup with modern C++ best practices

claude code "/git-pr-review"
# → Comprehensive PR analysis with quality gates
```

### Context-Aware Assistance
The configuration and context files help Claude Code understand:
- Your project's specific requirements and constraints
- Preferred tools and development patterns
- Performance targets and architectural decisions
- Team workflows and coding standards

## 🚀 Getting Started

1. **Use existing agents:** Try `@cpp-performance-expert` for optimization tasks
2. **Run commands:** Execute `/new-cpp-project` for new projects
3. **Customize config:** Modify `config.yaml` for your preferences
4. **Add context:** Update `CLAUDE.md` with project-specific information
5. **Create custom agents:** Add domain-specific expertise as needed

This folder structure transforms Claude Code from a general assistant into a specialized development partner tailored to your C++/HFT workflow.

## Updating

To update your dotfiles and all submodules:

```bash
cd ~/dotfiles
git pull
git submodule update --remote --merge

# For neovim config, optionally pull upstream improvements
cd nvim
git fetch upstream
git merge upstream/main  # if you want latest kickstart improvements
git push origin main

cd ..
git add nvim  # update the submodule reference
git commit -m "Update neovim config with upstream changes"
git push

# Update Homebrew packages
./homebrew/backup_brew.sh update
./homebrew/backup_brew.sh export  # Update Brewfile

./safe_install.sh  # Re-run if needed
```

## Complete System Setup Workflow

### First Time Setup (New Machine)

1. **Install Homebrew** (if not already installed):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Clone dotfiles**:
   ```bash
   git clone --recurse-submodules https://github.com/kmaune/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

3. **Run safe installation**:
   ```bash
   ./safe_install.sh
   ```

4. **Set up Aider (optional)**:
   ```bash
   # Install Aider
   pip install aider-chat
   
   # Install Ollama for local models
   brew install ollama
   ollama pull qwen2.5-coder:7b
   ollama pull qwen2.5-coder:32b
   
   # For cloud models, get OpenRouter API key and set:
   export OPENROUTER_API_KEY="your-key-here"
   ```

5. **Set up Claude Code (optional)**:
   ```bash
   # Install Claude Code
   npm install -g @anthropic-ai/claude-code
   # or
   brew install claude-code
   
   # Setup is automatic via install scripts
   # Access 9 specialized agents and 4 workflow commands
   ```

6. **Customize personal settings**:
   ```bash
   # Add personal Homebrew packages
   ./homebrew/backup_brew.sh personal
   # Edit homebrew/Brewfile.personal with your packages
   ./homebrew/backup_brew.sh install Brewfile.personal
   
   # Customize SSH if needed
   # Edit ssh/sshd_config.d/999-local.conf
   ./ssh/setup_ssh.sh
   ```

### Regular Maintenance

```bash
cd ~/dotfiles

# Update everything
git pull
git submodule update --remote --merge
./homebrew/backup_brew.sh update

# Export any new packages you've installed
./homebrew/backup_brew.sh export

# Commit and push updates
git add .
git commit -m "Update configurations and packages"
git push
```

### Before Migrating to New Machine

```bash
# Export current state
./homebrew/backup_brew.sh export
./envs/export_env.sh my-current-env

# Commit everything
git add .
git commit -m "Export current system state"
git push
```

## Troubleshooting

### Submodules not loading
```bash
git submodule update --init --recursive
```

### Scripts not executable
```bash
find ~/dotfiles/scripts -name "*.sh" -type f -exec chmod +x {} \;
find ~/dotfiles/homebrew -name "*.sh" -type f -exec chmod +x {} \;
find ~/dotfiles/ssh -name "*.sh" -type f -exec chmod +x {} \;
find ~/dotfiles/aider -name "*.sh" -type f -exec chmod +x {} \;
```

### Homebrew issues
```bash
# Check Homebrew status
~/dotfiles/homebrew/backup_brew.sh status

# Clean up Homebrew
~/dotfiles/homebrew/backup_brew.sh cleanup
```

### Aider issues
```bash
# Check available local models
ollama list

# Test cloud model connection
aider-deepseek --message "Hello, test message"

# See available aider configurations
aider-models
```

### Path not updated
```bash
source ~/.zshrc
```

### SSH configuration issues
```bash
# Test SSH configuration
sudo sshd -t

# Check SSH service status
sudo launchctl list | grep ssh
```

This dotfiles setup provides a complete, reproducible development environment that scales from personal projects to professional workflows while maintaining security and flexibility.
