# Ubuntu Server Setup Guide (P4 Mini Server)

Complete setup guide for Ubuntu 24.04 Server with dotfiles and Tailscale.

## Prerequisites

- Fresh Ubuntu 24.04 Server installation
- SSH access configured
- GitHub SSH key set up (for cloning private repos)

## System Package Installation

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Core utilities
sudo apt install -y \
  zsh \
  tmux \
  vim \
  git \
  curl \
  wget \
  htop \
  fzf \
  bat

# Neovim (latest from unstable PPA)
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install -y neovim

# Build tools (required for tree-sitter compilation and nvim plugins)
sudo apt install -y \
  build-essential \
  gcc \
  g++ \
  make \
  cmake \
  ripgrep \
  fd-find \
  clangd

# Node.js and npm (required for tree-sitter CLI and LSP servers)
sudo apt install -y nodejs npm

# Global npm packages
sudo npm install -g tree-sitter-cli

# Create bat symlink (Ubuntu installs it as batcat due to name conflict)
sudo ln -sf /usr/bin/batcat /usr/local/bin/bat

# Verify installations
nvim --version  # Should show v0.12.0-dev or later
tree-sitter --version  # Should show 0.26.5 or later
bat --version  # Should work (not batcat)
fzf --version  # Required for tmux sessionx plugin
```

## SSH Key Setup

### 1. Mac → Server Authentication

**On your Mac:**
```bash
# Generate key for server login
ssh-keygen -t ed25519 -f ~/.ssh/p4_server_key -C "mac-to-p4-server"

# Copy to server (replace with actual server IP)
ssh-copy-id -i ~/.ssh/p4_server_key kmaune@192.168.86.84

# Configure SSH client for easy access
cat >> ~/.ssh/config << 'EOF'
Host p4-server
    HostName 192.168.86.84
    User kmaune
    IdentityFile ~/.ssh/p4_server_key
EOF

# Test connection (should not ask for password)
ssh p4-server
```

### 2. Server → GitHub

**On the server:**
```bash
# Generate GitHub key
ssh-keygen -t ed25519 -f ~/.ssh/github_key -C "p4-server-github"

# Display public key
cat ~/.ssh/github_key.pub

# Add this to GitHub: https://github.com/settings/keys
# (Copy the output and paste into GitHub SSH keys)

# Configure SSH for GitHub
cat >> ~/.ssh/config << 'EOF'
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_key
EOF

# Test GitHub connection
ssh -T git@github.com
# Should see: "Hi kmaune! You've successfully authenticated..."
```

## Dotfiles Installation

```bash
# Clone dotfiles with submodules (use server branch)
git clone --recurse-submodules -b p4-mini-server-configs \
  git@github.com:kmaune/dotfiles.git ~/dotfiles

# Run install script
cd ~/dotfiles
./install_server.sh

# Change default shell to zsh
chsh -s /usr/bin/zsh

# Log out and back in for shell change to take effect
exit
```

## Neovim Configuration

The server branch already includes the tree-sitter config fix (`config` not `configs`).

**First launch:**
```bash
nvim
# Lazy.nvim will auto-install all plugins
# Wait for installation to complete (~1-2 minutes)
# Press 'q' to close the Lazy window when done
```

**Common nvim issues and fixes:**

If you see tree-sitter errors:
- Ensure tree-sitter CLI version is 0.26.1+: `tree-sitter --version`
- Ensure build-essential is installed: `gcc --version`
- Clean nvim data and restart:
  ```bash
  rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
  nvim
  ```

## Tmux Configuration

Tmux uses several plugins that auto-install on first use:

**Key features:**
- **Prefix**: `Ctrl+a` (not default `Ctrl+b`)
- **Sessionx**: `Ctrl+a` then `o` - fuzzy session switcher
- **Session persistence**: Auto-saves every 15 minutes, restores on restart
- **Custom splits**: `Ctrl+a` then `v` (vertical), `Ctrl+a` then `s` (horizontal)

**First launch:**
```bash
tmux
# Plugins install automatically via TPM
# Press Ctrl+a then Shift+I if they don't auto-install
```

## Tailscale Installation

Install Tailscale for remote access to the P4 from anywhere.

**Installation:**
```bash
# Install Tailscale
curl -fsSL https://tailscale.com/install.sh | sh

# Verify installation
tailscale version

# Connect to your Tailscale network
sudo tailscale up

# This will output a URL like: https://login.tailscale.com/a/xxxxx
# Open that URL in a browser and authenticate
```

**Verification:**
```bash
# Check status and see all devices on your network
tailscale status

# Get your Tailscale IP
tailscale ip -4

# Test connectivity to other devices
ping -c 3 100.100.57.86  # macbookserver
ping -c 3 100.71.156.70  # macbookpro
```

**Your P4's Tailscale identity:**
- Hostname: `p4-mini-server`
- Tailscale IP: `100.69.72.38`
- Can be accessed from any device on your Tailscale network

## Post-Installation

**Reconnect to see changes:**
```bash
# From your Mac
ssh p4-server
# Should show custom Nord-style prompt: username@hostname ~/path %
```

## Verification Checklist

Run these commands to verify everything works:

```bash
# Shell
echo $SHELL  # Should show /usr/bin/zsh

# Neovim
nvim --version  # v0.12.0-dev or later
nvim ~/.zshrc  # Should open with syntax highlighting, no errors

# Tmux
tmux  # Should start with custom prefix Ctrl+a
# Press: Ctrl+a then o  # Should open sessionx fuzzy finder
# Press: Ctrl+a then ?  # Should show custom keybindings

# Dependencies
tree-sitter --version  # 0.26.5+
bat --version  # Should work (not batcat)
fzf --version  # Required for sessionx
gcc --version  # Required for tree-sitter compilation

# SSH
ssh -T git@github.com  # Should authenticate successfully

# Tailscale
tailscale status  # Should show connected devices
tailscale ip -4  # Should show 100.69.72.38
```

## Troubleshooting

### Tmux issues
```bash
# If tmux immediately exits or has errors
tmux kill-server  # Kill all sessions
rm -rf ~/.local/share/tmux  # Clear tmux data
tmux  # Restart fresh

# If sessionx (Ctrl+a then o) doesn't work
which fzf  # Must be installed
which bat  # Must work (not batcat)
```

### Neovim issues
```bash
# If tree-sitter compilation fails
sudo apt install build-essential  # Ensure gcc is installed

# If plugins don't install
rm -rf ~/.local/share/nvim  # Clear nvim data
nvim  # Reinstall from scratch

# Check health
nvim
:checkhealth nvim-treesitter
```

### Zsh not default
```bash
# Verify zsh is in valid shells
cat /etc/shells | grep zsh

# If not, install zsh first
sudo apt install zsh

# Then change shell
chsh -s /usr/bin/zsh
```

### Tailscale issues
```bash
# Check if Tailscale daemon is running
sudo systemctl status tailscaled

# Restart Tailscale
sudo systemctl restart tailscaled

# Re-authenticate
sudo tailscale up

# Check connectivity
tailscale status
tailscale ping macbookserver
```

## Next Steps

After dotfiles and Tailscale are configured:

1. ✅ **Tailscale installed** - Remote access configured
2. **Install Docker** - Container runtime for services  
3. **Set up monitoring** - Extend Box 1 monitoring patterns
4. **Deploy services** - Jellyfin, Nextcloud, etc.

## Package Summary

**apt packages installed:**
- Core: zsh, tmux, vim, git, curl, wget, htop, fzf, bat
- Neovim: neovim (from ppa:neovim-ppa/unstable)
- Build tools: build-essential, gcc, g++, make, cmake, ripgrep, fd-find, clangd
- Runtime: nodejs, npm

**npm global packages:**
- tree-sitter-cli

**Additional installations:**
- Tailscale (via install script)

**Manual fixes:**
- Symlink: batcat → bat
- Neovim config: `configs` → `config` (already fixed in server branch)
