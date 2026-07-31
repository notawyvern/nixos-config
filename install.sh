#!/usr/bin/env bash
set -e

# checks if you are root
if [ "$EUID" -ne 0 ]
  then echo "WARNING: The script requires root privileges!"
  exit 1
fi

echo "NixOS Install Script"
echo "=========================="

echo
echo "WARNING: The disk /dev/sda will be COMPLETELY ERASED,"
echo "repartitioned, and the configuration will be deployed."
read -rp "Continue? (y/n) " -n 1 -r
echo
[[ $REPLY =~ ^[Yy]$ ]] || exit 1

export NIX_CONFIG="experimental-features = nix-command flakes"

nix run github:nix-community/disko/v1.13.0 -- \
    --yes-wipe-all-disks \
    --mode destroy,format,mount \
    --flake .#partitioning

nixos-install --flake .#nixos \
    --no-root-password \
    --no-bootloader \
    --no-channel-copy

mkdir -p /mnt/boot
mount /dev/sda2 /mnt/
mount /dev/sda1 /mnt/boot

nixos-enter << 'CHROOT_EOF'
set -e

# Setup Secure Boot keys
nix run nixpkgs#sbctl -- create-keys
nix run nixpkgs#sbctl -- enroll-keys -m -f

# Clone configuration so rebuild works
mkdir -p /etc/nixos
nix run nixpkgs#git -- clone https://github.com/notawyvern/nixos-config
cp -r nixos-config/modules nixos-config/flake.* /etc/nixos/
rm -rf nixos-config


# Complete the deployment
nixos-rebuild boot
CHROOT_EOF

echo
echo "Installation complete!"