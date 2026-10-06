#!/usr/bin/env bash

set -euo pipefail

# Require root privileges.
if [[ $EUID -ne 0 ]]; then
    echo "ERROR: This script requires root privileges." >&2
    exit 1
fi

echo "NixOS Installation"
echo "=================="

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DISKO_CONF="$SCRIPT_DIR/modules/hosts/nixos/_disko.nix"

echo
echo "Available disk devices:"
lsblk -dpno PATH
echo "========================================="
read -rp "Enter the target disk (e.g., /dev/vda): " DISK
echo
echo "WARNING: The selected disk will be completely erased,"
echo "repartitioned, and used for the NixOS installation."
read -rp "Continue? (y/N) " -n 1 -r
echo
[[ "$REPLY" =~ ^[Yy]$ ]] || exit 1

# Partition, format, and mount the target system using Disko.
export NIX_CONFIG="experimental-features = nix-command flakes"
nix run github:nix-community/disko/v1.13.0 -- \
    --yes-wipe-all-disks \
    --argstr drive "$DISK" \
    --mode destroy,format,mount "$DISKO_CONF"

# Install NixOS without a bootloader.
# The bootloader will be installed later to avoid conflicts with Secure Boot.
nixos-install --flake "$SCRIPT_DIR#nixos" \
    --no-root-password \
    --no-bootloader \
    --no-channel-copy

# Copy the flake configuration to the installed system.
mkdir -p /mnt/etc/nixos

cp -r \
    "$SCRIPT_DIR/flake.nix" \
    "$SCRIPT_DIR/flake.lock" \
    "$SCRIPT_DIR/modules" \
    /mnt/etc/nixos/

# Configure Secure Boot and install the bootloader.
nixos-enter <<CHROOT_EOF
set -euo pipefail

# Create and enroll Secure Boot keys.
nix run nixpkgs#sbctl -- create-keys
nix run nixpkgs#sbctl -- enroll-keys -m -f

# Install Limine.
NH_OS_FLAKE=/etc/nixos 
nh os boot -R --install-bootloader -H "nixos"
CHROOT_EOF

# Set the password for the primary user.
echo
echo "Set up credentials for crh:"
echo "============================"
nixos-enter --root /mnt -c 'passwd crh'

echo
echo "Installation complete!"
