#!/usr/bin/env bash
set -e

CONFIG_REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG_DIR="$HOME/.config/nvim"

echo "Installing Z3r0-Vim config with Lazy.nvim..."

# Backup if needed
if [ -e "$NVIM_CONFIG_DIR" ] && [ ! -L "$NVIM_CONFIG_DIR" ]; then
    echo "Backing up existing config..."
    mv "$NVIM_CONFIG_DIR" "$NVIM_CONFIG_DIR.backup.$(date +%s)"
fi

# Ensure parent folder exists
mkdir -p "$(dirname "$NVIM_CONFIG_DIR")"

# List of config files/folders to symlink
INCLUDES=(
  init.lua
  lua
  ftplugin
)

# Symlink each allowed entry
for item in "${INCLUDES[@]}"; do
  SRC="$CONFIG_REPO_DIR/$item"
  DEST="$NVIM_CONFIG_DIR/$item"

  if [ -e "$SRC" ]; then
    ln -sf "$SRC" "$DEST"
    echo "🔗 Linked $SRC → $DEST"
  fi
done

echo "Linked $CONFIG_REPO_DIR -> $NVIM_CONFIG_DIR"

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
