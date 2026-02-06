#!/bin/bash
# Verify Ubuntu Server installation

echo "============================================"
echo "System Package Verification"
echo "============================================"
echo ""

check_command() {
    local cmd=$1
    local expected_version=$2
    if command -v "$cmd" &> /dev/null; then
        local version=$($cmd --version 2>&1 | head -1)
        echo "✓ $cmd: $version"
        return 0
    else
        echo "✗ $cmd: NOT FOUND"
        return 1
    fi
}

check_command "zsh"
check_command "tmux"
check_command "vim"
check_command "nvim"
check_command "git"
check_command "curl"
check_command "wget"
check_command "htop"
check_command "fzf"
check_command "bat"
check_command "gcc"
check_command "make"
check_command "cmake"
check_command "clangd"
check_command "rg"
check_command "node"
check_command "npm"
check_command "tree-sitter"
check_command "unzip"
check_command "openconnect"

echo ""
echo "============================================"
echo "Dotfiles Symlinks"
echo "============================================"
echo ""

check_symlink() {
    local link=$1
    if [ -L "$link" ]; then
        local target=$(readlink "$link")
        echo "✓ $link → $target"
    else
        echo "✗ $link: NOT A SYMLINK"
    fi
}

check_symlink ~/.vim
check_symlink ~/.config/nvim
check_symlink ~/.config/tmux
check_symlink ~/.zshrc
check_symlink ~/.gitconfig

echo ""
echo "============================================"
echo "Shell Configuration"
echo "============================================"
echo ""

echo "Current shell: $SHELL"
if [ "$SHELL" = "/usr/bin/zsh" ]; then
    echo "✓ Zsh is default shell"
else
    echo "⚠️  Default shell is not zsh. Run: chsh -s /usr/bin/zsh"
fi

echo ""
echo "============================================"
echo "Tmux Plugins"
echo "============================================"
echo ""

if [ -d ~/.config/tmux/plugins/tpm ]; then
    echo "✓ TPM installed"
    ls ~/.config/tmux/plugins/ | while read plugin; do
        echo "  - $plugin"
    done
else
    echo "✗ TPM not installed"
fi

echo ""
echo "============================================"
echo "Neovim Health Check"
echo "============================================"
echo ""
echo "Run 'nvim' and execute ':checkhealth' for detailed nvim diagnostics"

