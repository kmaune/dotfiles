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
check_command "tailscale"
check_command "docker"

echo ""
echo "============================================"
echo "Docker Compose"
echo "============================================"
echo ""

if command -v docker &> /dev/null; then
    if docker compose version &> /dev/null; then
        COMPOSE_VERSION=$(docker compose version 2>&1)
        echo "✓ $COMPOSE_VERSION"
    else
        echo "✗ docker compose: NOT FOUND"
    fi
else
    echo "✗ Docker not installed"
fi

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
echo "Tailscale Configuration"
echo "============================================"
echo ""

if command -v tailscale &> /dev/null; then
    if tailscale status &> /dev/null; then
        echo "✓ Tailscale connected"
        TAILSCALE_IP=$(tailscale ip -4 2>/dev/null)
        echo "  Tailscale IP: $TAILSCALE_IP"
        echo "  Hostname: $(hostname)"
        
        # Check if advertising as exit node
        if tailscale status | grep -q "offers exit node"; then
            echo "  Exit node: ✓ Advertising"
        else
            echo "  Exit node: ✗ Not advertising"
        fi
        
        # Check IP forwarding
        IPV4_FORWARD=$(sysctl -n net.ipv4.ip_forward 2>/dev/null)
        IPV6_FORWARD=$(sysctl -n net.ipv6.conf.all.forwarding 2>/dev/null)
        if [ "$IPV4_FORWARD" = "1" ] && [ "$IPV6_FORWARD" = "1" ]; then
            echo "  IP forwarding: ✓ Enabled"
        else
            echo "  IP forwarding: ✗ Disabled (required for exit node)"
        fi
    else
        echo "⚠️  Tailscale installed but not connected"
        echo "  Run: sudo tailscale up"
    fi
else
    echo "✗ Tailscale not installed"
fi

echo ""
echo "============================================"
echo "Docker Configuration"
echo "============================================"
echo ""

if command -v docker &> /dev/null; then
    # Check if docker daemon is running
    if docker info &> /dev/null; then
        echo "✓ Docker daemon running"
        
        # Check if user is in docker group
        if groups | grep -q docker; then
            echo "  Docker group: ✓ User in docker group"
        else
            echo "  Docker group: ✗ User not in docker group"
            echo "    Run: sudo usermod -aG docker $USER"
            echo "    Then log out and back in"
        fi
        
        # Check docker service status
        if systemctl is-enabled docker &> /dev/null; then
            echo "  Auto-start: ✓ Enabled"
        else
            echo "  Auto-start: ✗ Disabled"
        fi
    else
        echo "⚠️  Docker installed but daemon not running"
        echo "  Run: sudo systemctl start docker"
    fi
else
    echo "✗ Docker not installed"
fi

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

echo ""
echo "============================================"
echo "Quick Tests"
echo "============================================"
echo ""
echo "To test Docker, run:"
echo "  docker run hello-world"
echo ""
echo "To test Tailscale connectivity, run:"
echo "  ping -c 3 100.100.57.86  # macbookserver"
echo ""
