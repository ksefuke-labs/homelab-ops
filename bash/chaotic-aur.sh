#!/usr/bin/bash
echo "Updating archlinux-keyring..."
pacman -Sy archlinux-keyring --noconfirm || exit 1

sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
if ! grep -q "^\[chaotic-aur\]" /etc/pacman.conf; then
    echo "Adding Chaotic-aur repository to pacman.conf..."
    echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf
fi
sudo pacman -Syu --noconfirm || exit 1