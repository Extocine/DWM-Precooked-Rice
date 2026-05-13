#!/bin/bash

set -e

echo "==> Starting DWM rice installation..."

# Detect package manager
if command -v apt >/dev/null 2>&1; then
    PKG_INSTALL="sudo apt install -y"
    PKGS="xorg git make gcc libxft-dev libxinerama-dev"
elif command -v pacman >/dev/null 2>&1; then
    PKG_INSTALL="sudo pacman -S --noconfirm"
    PKGS="xorg-server xorg-xinit git make gcc libxft libxinerama"
elif command -v dnf >/dev/null 2>&1; then
    PKG_INSTALL="sudo dnf install -y"
    PKGS="xorg-x11-server-Xorg git make gcc libXft-devel libXinerama-devel"
else
    echo "Unsupported package manager."
    exit 1
fi

echo "==> Installing dependencies..."
$PKG_INSTALL $PKGS

# Create config directories
echo "==> Creating config directories..."
mkdir -p ~/.config/dwm
mkdir -p ~/.config/kitty

# Build and install suckless software
echo "==> Installing dwm..."
cd dwm/dwm
sudo make clean install

echo "==> Installing dmenu..."
cd ../dmenu
sudo make clean install

echo "==> Installing slock..."
cd ../slock
sudo make clean install

echo "==> Installing st..."
cd ../st
sudo make clean install

# Return to root directory
cd ../../

echo "==> Copying configuration files..."

# Copy suckless source folders into ~/.config/dwm
cp -r dwm/dwm ~/.config/dwm/
cp -r dwm/dmenu ~/.config/dwm/
cp -r dwm/slock ~/.config/dwm/
cp -r dwm/st ~/.config/dwm/

# Copy kitty config
cp -r rice/kitty ~/.config/

# Copy live wallpapers
cp -r rice/livewallpapers ~/.config/dwm/

# Copy picom config
cp rice/picom.conf ~/.config/

# Copy scripts
cp rice/dwm-emoji.sh ~/.config/dwm/
cp rice/dwm-power.sh ~/.config/dwm/
cp rice/dwm-status.sh ~/.config/dwm/

# Make scripts executable
chmod +x ~/.config/dwm/*.sh
chmod +x ~/.config/dwm/livewallpapers/*.sh

echo
echo "========================================"
echo "      INSTALLATION COMPLETE!"
echo "========================================"
echo
echo "Recommended quality-of-life packages:"
echo
echo "feh ffmpeg curl flameshot picom mpv alsa-utils pavucontrol kitty neofetch slock playerctl nemo arandr parcellite brightnessctl acpi wireless-tools xdotool"
echo
echo "Extra desktop software:"
echo
echo "qbittorrent keepassxc syncthing veracrypt brave-browser discord steam gparted timeshift vlc plymouth"
echo
echo "You can now launch dwm using startx or your display manager."
