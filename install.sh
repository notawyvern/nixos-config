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

# Select the target host.
while true; do
    read -rp "Select device (1: desktop, 2: laptop): " DEVICE

    case "$DEVICE" in
        1)
            HOSTNAME="desktop"
            break
            ;;
        2)
            HOSTNAME="laptop"
            break
            ;;
        *)
            echo "Invalid selection. Please enter 1 or 2."
            ;;
    esac
done

DISKO_CONF="$SCRIPT_DIR/modules/hosts/$HOSTNAME/_disko.nix"

PASSFILE="$(mktemp)"
trap 'rm -f -- "$PASSFILE"' EXIT

# Request and verify the LUKS encryption password on laptops.
if [[ "$HOSTNAME" == "laptop" ]]; then
    while true; do
        read -rsp "Enter LUKS encryption password: " PASS
        echo

        if [[ -z "$PASS" ]]; then
            echo "Password cannot be empty."
            continue
        fi

        read -rsp "Confirm LUKS encryption password: " PASS_CONFIRM
        echo

        if [[ "$PASS" == "$PASS_CONFIRM" ]]; then
            break
        fi

        echo "Passwords do not match. Try again."
    done

    printf '%s' "$PASS" > "$PASSFILE"
    unset PASS PASS_CONFIRM
fi

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

export NIX_CONFIG="experimental-features = nix-command flakes"

# Partition, format, and mount the target system using Disko.
nix run github:nix-community/disko/v1.13.0 -- \
    --yes-wipe-all-disks \
    --argstr drive "$DISK" \
    --argstr passwordfile "$PASSFILE" \
    --mode destroy,format,mount "$DISKO_CONF"

# Install NixOS without a bootloader.
# The bootloader will be installed later to avoid conflicts with Secure Boot.
nixos-install --flake "$SCRIPT_DIR#$HOSTNAME" \
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
nixos-rebuild boot --flake /etc/nixos#$HOSTNAME
CHROOT_EOF

# Enroll the LUKS volume with the TPM on laptops.
if [[ "$HOSTNAME" == "laptop" ]]; then
    systemd-cryptenroll \
        --tpm2-device=auto \
        /dev/disk/by-partlabel/disk-main-ROOT
fi

# Set the password for the primary user.
echo
echo "Set up credentials for crh:"
echo "============================"
nixos-enter --root /mnt -c 'passwd crh'

echo
echo "Installation complete!"
