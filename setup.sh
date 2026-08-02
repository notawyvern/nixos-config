#!/bin/bash
set -e

# Prompt for device names
echo "NixOS Setup Script"
echo "=========================="
read -p "Enter boot partition (e.g., /dev/sda1): " BOOT_PART
read -p "Enter root partition (e.g., /dev/sda2): " ROOT_PART

# Validate input
if [[ -z "$BOOT_PART" || -z "$ROOT_PART" ]]; then
	echo "Error: Both partition paths must be provided"
	exit 1
fi

echo "Using root partition: $ROOT_PART"
echo "Using boot partition: $BOOT_PART"
read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
	exit 1
fi

sudo bash <<ROOT_EOF
mkdir -p /mnt/boot
mount $ROOT_PART /mnt/
mount $BOOT_PART /mnt/boot

nixos-enter << 'CHROOT_EOF'
set -e

# Deletes bootloader to replace it with Limine
rm -rf /boot/*

# Configuration cloning and cleanup
nix-shell -p sbctl efibootmgr git --run bash << 'SHELL_EOF'
set -e
git clone -b update_flake_lock_action https://github.com/notawyvern/nixos-config.git
cp -r nixos-config/modules nixos-config/flake.* /etc/nixos/
rm -rf nixos-config
rm /etc/nixos/configuration.nix

# Setup Secure Boot keys
sbctl create-keys
sbctl enroll-keys -m -f
SHELL_EOF

# Remove channels for flakes
nix-channel --remove nixos
rm -rf /nix/var/nix/profiles/per-user/root /root/.nix-defexpr/channels
nix-collect-garbage -d

# Complete the deployment
nixos-rebuild boot
CHROOT_EOF
ROOT_EOF

echo "Setup complete!"