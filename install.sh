#!/usr/bin/env bash
# Z3r0-Vim: symlink this repo to ~/.config/nvim and bootstrap lazy.nvim.
#
# System prerequisites (see README "System prerequisites"):
#   Required:    git, nvim
#   Recommended: rg (ripgrep), fd, gcc or clang, make, curl, unzip
#   Optional:     lazygit (LazyGit.nvim commands)
#   Not covered: JDK (Java/jdtls), Rust toolchain, gdb/lldb (DAP), formatters
#                installed via Mason, Nerd Fonts, ffmpeg/ImageMagick for media previews.
#
# Usage: ./install.sh [--install-deps] [--help]
#   --install-deps  Install recommended packages (sudo; Arch, Debian/Ubuntu, Fedora, or Homebrew on macOS).

set -e

CONFIG_REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
INSTALL_DEPS=0

usage() {
    cat <<'EOF'
Usage: ./install.sh [--install-deps] [--help]
  --install-deps       Install recommended system packages (sudo on Linux; Homebrew on macOS).
  --help, -h           Show this help.
EOF
}

while [ $# -gt 0 ]; do
    case "$1" in
        --install-deps) INSTALL_DEPS=1 ;;
        --help | -h)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            usage >&2
            exit 1
            ;;
    esac
    shift
done

have_cmd() {
    command -v "$1" >/dev/null 2>&1
}

have_c_compiler() {
    have_cmd gcc || have_cmd clang
}

have_fd() {
    have_cmd fd || have_cmd fdfind
}

detect_pkg_family() {
    if [[ "$(uname -s)" == "Darwin" ]]; then
        echo "darwin"
    elif [ -f /etc/arch-release ]; then
        echo "arch"
    elif [ -f /etc/debian_version ]; then
        echo "debian"
    elif [ -f /etc/fedora-release ] || [ -f /etc/redhat-release ]; then
        echo "fedora"
    else
        echo "unknown"
    fi
}

print_install_hints() {
    local fam
    fam="$(detect_pkg_family)"
    echo "Install hints (pick what matches your system):"
    case "$fam" in
        arch)
            echo "  sudo pacman -S --needed neovim git ripgrep fd gcc make curl unzip lazygit"
            ;;
        debian)
            echo "  sudo apt-get update && sudo apt-get install -y neovim git ripgrep fd-find build-essential curl unzip lazygit"
            echo "  (On Debian/Ubuntu, package fd-find provides the fdfind binary; this script can symlink fd when using --install-deps.)"
            ;;
        fedora)
            echo "  sudo dnf install -y neovim git ripgrep fd gcc make curl unzip lazygit"
            ;;
        darwin)
            echo "  brew install neovim git ripgrep fd gcc make curl unzip lazygit"
            ;;
        *)
            echo "  Install: git, Neovim, ripgrep, fd, a C compiler, make, curl, unzip; optional: lazygit."
            ;;
    esac
}

install_deps_for_family() {
    local fam
    fam="$(detect_pkg_family)"
    case "$fam" in
        arch)
            sudo pacman -S --needed --noconfirm neovim git ripgrep fd gcc make curl unzip lazygit
            ;;
        debian)
            sudo apt-get update
            sudo apt-get install -y neovim git ripgrep fd-find build-essential curl unzip lazygit
            if have_cmd fdfind && ! have_cmd fd; then
                sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd
                echo "Created /usr/local/bin/fd -> fdfind (Telescope expects fd in PATH)."
            fi
            ;;
        fedora)
            sudo dnf install -y neovim git ripgrep fd gcc make curl unzip lazygit
            ;;
        darwin)
            if ! have_cmd brew; then
                echo "Homebrew not found. Install from https://brew.sh then re-run with --install-deps." >&2
                exit 1
            fi
            brew install neovim git ripgrep fd gcc make curl unzip lazygit
            ;;
        *)
            echo "Automatic install is not supported on this OS. Install packages manually:" >&2
            print_install_hints
            exit 1
            ;;
    esac
}

check_prerequisites() {
    local fatal=0

    if ! have_cmd git; then
        echo "ERROR: git is required (Lazy bootstrap, Gitsigns, this script)." >&2
        fatal=1
    fi
    if ! have_cmd nvim; then
        echo "ERROR: nvim (Neovim) is required." >&2
        fatal=1
    fi
    if [ "$fatal" -eq 1 ]; then
        print_install_hints
        exit 1
    fi

    local warn=0
    if ! have_cmd rg; then
        echo "WARN: ripgrep (rg) not found — Telescope live-grep and todo-comments search expect it."
        warn=1
    fi
    if ! have_fd; then
        echo "WARN: fd not found — Telescope file search works best with fd (falls back to find)."
        warn=1
    fi
    if ! have_c_compiler; then
        echo "WARN: no gcc/clang in PATH — nvim-treesitter may fail to compile parsers."
        warn=1
    fi
    if ! have_cmd make; then
        echo "WARN: make not found — needed for some plugin builds (e.g. codesnap.nvim)."
        warn=1
    fi
    if ! have_cmd curl; then
        echo "WARN: curl not found — Mason and many downloads expect it."
        warn=1
    fi
    if ! have_cmd unzip; then
        echo "WARN: unzip not found — Mason often needs it to unpack releases."
        warn=1
    fi
    if ! have_cmd lazygit; then
        echo "NOTE: lazygit not in PATH — LazyGit.nvim commands (<leader>gg) need the lazygit binary."
    fi

    if [ "$warn" -eq 1 ]; then
        echo ""
        print_install_hints
        echo "Or run: ./install.sh --install-deps"
    fi
}

if [ "$INSTALL_DEPS" -eq 1 ]; then
    install_deps_for_family
fi

check_prerequisites

echo "Installing Z3r0-Vim config with Lazy.nvim..."

# Backup if needed
if [ -e "$NVIM_CONFIG_DIR" ] && [ ! -L "$NVIM_CONFIG_DIR" ]; then
    echo "Backing up existing config..."
    mv "$NVIM_CONFIG_DIR" "$NVIM_CONFIG_DIR.backup.$(date +%s)"
fi

# Ensure parent folder exists
mkdir -p "$(dirname "$NVIM_CONFIG_DIR")"

echo "Linked $CONFIG_REPO_DIR -> $NVIM_CONFIG_DIR"
ln -sf "$CONFIG_REPO_DIR" "$NVIM_CONFIG_DIR"

# Ensure lazy.nvim is installed
LAZY_PATH="$HOME/.local/share/nvim/lazy/lazy.nvim"
if [ ! -d "$LAZY_PATH" ]; then
    echo "Installing lazy.nvim..."
    git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable "$LAZY_PATH"
fi

# Optionally sync plugins
read -rp "Do you want to install plugins via Lazy.nvim now? (y/N): " yn
if [[ "$yn" =~ ^[Yy]$ ]]; then
    nvim --headless "+Lazy! sync" +qa
fi

echo "✅ Z3r0-Vim setup complete."
