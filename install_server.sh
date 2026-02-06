#!/bin/bash
# Ubuntu Server dotfiles installation

echo "Installing Ubuntu Server dotfiles..."

# Create symlinks
mkdir -p ~/.config
ln -sf ~/dotfiles/vim ~/.vim
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/tmux ~/.config/tmux
ln -sf ~/dotfiles/shell/zshrc ~/.zshrc
ln -sf ~/dotfiles/git/gitconfig ~/.gitconfig

# Install tmux plugins
~/.config/tmux/plugins/tpm/bin/install_plugins

echo "✓ Dotfiles installed"
echo "Note: Install system packages first (see README.md)"
echo "Then run: chsh -s /usr/bin/zsh"
