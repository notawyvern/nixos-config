#!/usr/bin/env bash
set -euo pipefail

# Checks if you are root
if [[ $EUID -ne 0 ]]; then
    echo "WARNING: This script requires root privileges!" >&2
    exit 1
fi

echo "NixOS Install Script"
echo "===================="
echo
echo "WARNING: The disk will be COMPLETELY ERASED,"
echo "repartitioned, and NixOS will be deployed."
read -rp "Continue? (y/N) " -n 1 -r
echo
[[ $REPLY =~ ^[Yy]$ ]] || exit 1

export SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export NIX_CONFIG="experimental-features = nix-command flakes"

# Partition, format, and mount the system using Disko.
nix run github:nix-community/disko/v1.13.0 -- \
    --yes-wipe-all-disks \
    --mode destroy,format,mount \
    --flake "$SCRIPT_DIR"#partitioning

# Install the bootloader later 
# not to conflict with Secure Boot
nixos-install --flake "$SCRIPT_DIR"#nixos \
    --no-root-password \
    --no-bootloader \
    --no-channel-copy

# Copy the flake so the installed system
# has a configuration to rebuild to
mkdir -p /mnt/etc/nixos
cp -r "$SCRIPT_DIR"/flake.nix \
      "$SCRIPT_DIR"/flake.lock \
      "$SCRIPT_DIR"/modules \
      /mnt/etc/nixos/

nixos-enter --root /mnt -c 'passwd crh'
nixos-enter <<'CHROOT_EOF'
set -euo pipefail

# Create and enroll Secure Boot keys
nix run nixpkgs#sbctl -- create-keys
nix run nixpkgs#sbctl -- enroll-keys -m -f

# Installs Limine
nixos-rebuild boot
CHROOT_EOF

echo
echo "Installation complete!"
