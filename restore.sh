#!/bin/bash
# System Config Restore Script
# Usage: ./restore.sh

set -e

BACKUP_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Restoring system config from: $BACKUP_DIR ==="

# Shell configs
echo "Restoring shell configs..."
cp -f "$BACKUP_DIR/.bashrc" ~/
cp -f "$BACKUP_DIR/.bash_profile" ~/ 2>/dev/null || true
cp -f "$BACKUP_DIR/.zshrc" ~/
cp -f "$BACKUP_DIR/.zprofile" ~/
cp -f "$BACKUP_DIR/.profile" ~/
cp -f "$BACKUP_DIR/.p10k.zsh" ~/ 2>/dev/null || true

# Oh-My-Zsh
if [ -d "$BACKUP_DIR/oh-my-zsh" ]; then
  cp -rf "$BACKUP_DIR/oh-my-zsh" ~/ 2>/dev/null || true
fi

# Neovim config
if [ -d "$BACKUP_DIR/config_selected/nvim" ]; then
  mkdir -p ~/.config/nvim
  cp -rf "$BACKUP_DIR/config_selected/nvim/"* ~/.config/nvim/
fi

# VSCode settings (if backup exists)
if [ -d "$BACKUP_DIR/config_selected/Code" ]; then
  mkdir -p ~/.config/Code/User
  cp -rf "$BACKUP_DIR/config_selected/Code/"* ~/.config/Code/User/ 2>/dev/null || true
fi

# SSH known_hosts (no private keys)
if [ -f "$BACKUP_DIR/ssh_known_hosts" ]; then
  mkdir -p ~/.ssh
  cp -f "$BACKUP_DIR/ssh_known_hosts" ~/.ssh/
  cp -f "$BACKUP_DIR/ssh_known_hosts.old" ~/.ssh/ 2>/dev/null || true
fi

# ROS distro hint
if [ -f "$BACKUP_DIR/ros_distro.txt" ]; then
  echo "ROS distro: $(cat "$BACKUP_DIR/ros_distro.txt")"
fi

# Other .config items
for d in fcitx5 gtk-3.0 gtk-4.0 tiling-assistant; do
  if [ -d "$BACKUP_DIR/config_selected/$d" ]; then
    mkdir -p ~/.config/$d
    cp -rf "$BACKUP_DIR/config_selected/$d/"* ~/.config/$d/ 2>/dev/null || true
  fi
done

echo "=== Restore complete ==="
echo "NOTE: Log out and log back in for shell changes to take effect."
echo "NOTE: VSCode extensions need to be reinstalled separately: code --list-extensions"
echo "NOTE: Snap apps need to be reinstalled separately."
echo "NOTE: For full restore on new machine, also backup: ~/.ssh/id_* (private keys)"
