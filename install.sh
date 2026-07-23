#!/usr/bin/env bash
set -euo pipefail

REPO="https://github.com/pansususu/NixOS"
DISK="/dev/nvme0n1"

echo "Target: $DISK"
echo "Layout:"
echo "  ${DISK}p1  -> EFI     (1G)"
echo "  ${DISK}p2  -> SWAP    (16G)"
echo "  ${DISK}p3  -> /       (70G)"
echo "  ${DISK}p4  -> /home   (rest)"
echo ""
read -rp 'Type "yes" to continue: ' answer
[ "$answer" = "yes" ] || exit 1

set -x

# Partition
parted "$DISK" -- mklabel gpt \
    mkpart primary fat32 1MiB 1025MiB \
    mkpart primary linux-swap 1025MiB 17409MiB \
    mkpart primary ext4 17409MiB 89473MiB \
    mkpart primary ext4 89473MiB 100% \
    set 1 esp on

sleep 2

# Format
mkfs.fat -F 32 -n NIXBOOT "${DISK}p1"
mkswap -L NIXSWAP "${DISK}p2"
mkfs.ext4 -L NIXROOT "${DISK}p3"
mkfs.ext4 -L NIXHOME "${DISK}p4"

# Mount
mount "${DISK}p3" /mnt
mount --mkdir "${DISK}p1" /mnt/boot
mount --mkdir "${DISK}p4" /mnt/home
swapon "${DISK}p2"

# Clone config
nix-env -iA nixos.git 2>/dev/null || true
git clone "$REPO" /mnt/etc/nixos

# Generate hardware config for target
nixos-generate-config --root /mnt

# Install
nixos-install --no-root-passwd --flake /mnt/etc/nixos#finix

echo ""
echo "Done! Reboot with: sudo reboot"
