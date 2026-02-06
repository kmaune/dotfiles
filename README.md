# Ubuntu Server Setup Guide (P4 Mini Server)

Complete setup guide for Ubuntu 24.04 Server with dotfiles.

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

# Build tools (for tree-sitter and compilation)
sudo apt install -y \
  build-essential \
  gcc \
  g++ \
  make \
  cmake \
  ripgrep \
  fd-find

# Node.js and npm (for tree-sitter CLI and LSP servers)
sudo apt install -y nodejs npm

# Tree-sitter CLI (required for nvim syntax highlighting)
sudo npm install -g tree-sitter-cli
```

## SSH Key Setup

### 1. Mac → Server Authentication

**On your Mac:**
```bash
# Generate key
ssh-keygen -t ed25519 -f ~/.ssh/p4_server_key -C "mac-to-p4-server"

# Copy to server
ssh-copy-id -i ~/.ssh/p4_server_key kmaune@192.168.86.84

# Configure SSH client
vim ~/.ssh/config
# Add:
# Host p4-server
#     HostName 192.168.86.84
#     User kmaune
#     IdentityFile ~/.ssh/p4_server_key
```

### 2. Server → GitHub

**On the server:**
```bash
# Generate GitHub key
ssh-keygen -t ed25519 -f ~/.ssh/github_key -C "p4-server-github"

# Display public key
cat ~/.ssh/github_key.pub
# Add this to GitHub: https://github.com/settings/keys

# Configure SSH for GitHub
vim ~/.ssh/config
# Add:
# Host github.com
#     HostName github.com
#     User git
#     IdentityFile ~/.ssh/github_key

# Test connection
ssh -T git@github.com
```

## Dotfiles Installation
```bash
# Clone dotfiles with submodules (use server branch)
git clone --recurse-submodules -b p4-mini-server-configs \
  git@github.com:kmaune/dotfiles.git ~/dotfiles

# Create symlinks
mkdir -p ~/.config
ln -sf ~/dotfiles/vim ~/.vim
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/tmux ~/.config/tmux
ln -sf ~/dotfiles/shell/zshrc ~/.zshrc
ln -sf ~/dotfiles/git/gitconfig ~/.gitconfig

# Install tmux plugins
~/.config/tmux/plugins/tpm/bin/install_plugins

# Change default shell to zsh
chsh -s /usr/bin/zsh
```

## Neovim Setup

After first launching nvim, fix tree-sitter config if needed:

**Edit:** `~/dotfiles/nvim/lua/kickstart/plugins/treesitter.lua`

Ensure line 5 says:
```lua
main = 'nvim-treesitter.config',  -- Note: 'config' not 'configs'
```

Then restart nvim and let plugins install.

## Post-Installation

Log out and back in for zsh to take effect:
```bash
exit
ssh p4-server
```

You should see your custom Nord-style prompt!

## Verification Checklist

- [ ] Zsh is default shell with custom prompt
- [ ] Tmux works with plugins (Ctrl+a then o for sessionx)
- [ ] Nvim opens without errors, syntax highlighting works
- [ ] SSH keys work for both GitHub and Mac → Server
- [ ] All dotfiles symlinks are correct

## Next Steps

- Install Tailscale for remote access
- Install Docker for containerized services
- Set up monitoring and alerting
- Deploy services (Jellyfin, etc.)
