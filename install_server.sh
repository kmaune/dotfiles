#!/bin/bash
# Ubuntu Server dotfiles installation script
# For use with p4-mini-server-configs branch

set -e  # Exit on error

echo "============================================"
echo "Ubuntu Server Dotfiles Installation"
echo "============================================"
echo ""

# Check if we're on the right branch
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "p4-mini-server-configs" ]; then
    echo "⚠️  Warning: Not on p4-mini-server-configs branch (current: $CURRENT_BRANCH)"
    read -p "Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Initialize submodules
echo "Initializing git submodules..."
git submodule update --init --recursive
echo "✓ Git submodules initialized"
echo ""

# Create symlinks
echo "Creating symlinks..."
mkdir -p ~/.config

# Backup existing configs if they're not symlinks
backup_if_exists() {
    local target=$1
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "  Backing up existing $target to ${target}.backup"
        mv "$target" "${target}.backup"
    fi
}

backup_if_exists ~/.vim
backup_if_exists ~/.config/nvim
backup_if_exists ~/.config/tmux
backup_if_exists ~/.zshrc
backup_if_exists ~/.gitconfig

# Create symlinks
ln -sf ~/dotfiles/vim ~/.vim
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/tmux ~/.config/tmux
ln -sf ~/dotfiles/shell/zshrc ~/.zshrc
ln -sf ~/dotfiles/git/gitconfig ~/.gitconfig

echo "✓ Symlinks created"
echo ""

# Verify dependencies
echo "Verifying system dependencies..."

check_command() {
    local cmd=$1
    local package=$2
    if command -v "$cmd" &> /dev/null; then
        echo "  ✓ $cmd installed"
        return 0
    else
        echo "  ✗ $cmd NOT installed (package: $package)"
        return 1
    fi
}

MISSING_PACKAGES=()

# Check core packages
check_command "zsh" "zsh" || MISSING_PACKAGES+=("zsh")
check_command "tmux" "tmux" || MISSING_PACKAGES+=("tmux")
check_command "vim" "vim" || MISSING_PACKAGES+=("vim")
check_command "git" "git" || MISSING_PACKAGES+=("git")
check_command "curl" "curl" || MISSING_PACKAGES+=("curl")
check_command "wget" "wget" || MISSING_PACKAGES+=("wget")
check_command "unzip" "unzip" || MISSING_PACKAGES+=("unzip")
check_command "htop" "htop" || MISSING_PACKAGES+=("htop")
check_command "fzf" "fzf" || MISSING_PACKAGES+=("fzf")
check_command "openconnect" "openconnect" || MISSING_PACKAGES+=("openconnect")

# Check bat (might be batcat)
if command -v bat &> /dev/null; then
    echo "  ✓ bat installed"
elif command -v batcat &> /dev/null; then
    echo "  ⚠️  batcat installed but bat symlink missing"
    MISSING_PACKAGES+=("bat-symlink")
else
    echo "  ✗ bat NOT installed (package: bat)"
    MISSING_PACKAGES+=("bat")
fi

# Check nvim
if command -v nvim &> /dev/null; then
    NVIM_VERSION=$(nvim --version | head -1)
    echo "  ✓ nvim installed ($NVIM_VERSION)"
else
    echo "  ✗ nvim NOT installed (add PPA: ppa:neovim-ppa/unstable)"
    MISSING_PACKAGES+=("neovim")
fi

# Check build tools
check_command "gcc" "build-essential" || MISSING_PACKAGES+=("build-essential")
check_command "make" "build-essential" || MISSING_PACKAGES+=("build-essential")
check_command "cmake" "cmake" || MISSING_PACKAGES+=("cmake")
check_command "rg" "ripgrep" || MISSING_PACKAGES+=("ripgrep")
check_command "clangd" "clangd" || MISSING_PACKAGES+=("clangd")

# Check Node.js/npm
check_command "node" "nodejs" || MISSING_PACKAGES+=("nodejs")
check_command "npm" "npm" || MISSING_PACKAGES+=("npm")

# Check npm global packages
if command -v tree-sitter &> /dev/null; then
    TS_VERSION=$(tree-sitter --version)
    echo "  ✓ tree-sitter installed ($TS_VERSION)"
else
    echo "  ✗ tree-sitter NOT installed (npm: tree-sitter-cli)"
    MISSING_PACKAGES+=("tree-sitter-cli")
fi

echo ""

# Report missing packages
if [ ${#MISSING_PACKAGES[@]} -gt 0 ]; then
    echo "⚠️  Missing dependencies detected!"
    echo ""
    echo "Install missing packages with:"
    echo "  sudo apt update"
    echo "  sudo apt install -y ${MISSING_PACKAGES[@]}"
    echo ""
    echo "For neovim, add PPA first:"
    echo "  sudo add-apt-repository ppa:neovim-ppa/unstable -y"
    echo "  sudo apt update && sudo apt install neovim"
    echo ""
    echo "For tree-sitter:"
    echo "  sudo npm install -g tree-sitter-cli"
    echo ""
    read -p "Continue with dotfiles setup anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Fix bat symlink if needed
if command -v batcat &> /dev/null && ! command -v bat &> /dev/null; then
    echo "Creating bat symlink..."
    sudo ln -sf /usr/bin/batcat /usr/local/bin/bat
    echo "✓ bat symlink created"
    echo ""
fi

# Install tmux plugins
echo "Installing tmux plugins..."
if [ -d ~/.config/tmux/plugins/tpm ]; then
    ~/.config/tmux/plugins/tpm/bin/install_plugins
    echo "✓ Tmux plugins installed"
else
    echo "⚠️  TPM not found in submodules"
fi
echo ""

# Verify npm packages
if command -v npm &> /dev/null; then
    echo "Checking npm global packages..."
    
    if ! command -v tree-sitter &> /dev/null; then
        echo "Installing tree-sitter-cli..."
        sudo npm install -g tree-sitter-cli
        echo "✓ tree-sitter-cli installed"
    else
        echo "✓ tree-sitter-cli already installed"
    fi
else
    echo "⚠️  npm not available, skipping tree-sitter-cli installation"
fi
echo ""

# Final summary
echo "============================================"
echo "Installation Complete!"
echo "============================================"
echo ""
echo "Dotfiles have been installed and symlinked."
echo ""
echo "Next steps:"
echo "  1. Verify all dependencies are installed (see above)"
echo "  2. Change default shell: chsh -s /usr/bin/zsh"
echo "  3. Log out and back in for shell change to take effect"
echo "  4. Test tmux: tmux (then Ctrl+a then o for sessionx)"
echo "  5. Test nvim: nvim (plugins will auto-install on first launch)"
echo ""
echo "To verify installation, run:"
echo "  ~/dotfiles/verify_install.sh"
echo ""
