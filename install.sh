#!/usr/bin/env bash

set -e

echo "[*] Detecting distribution..."

# ----------------------------
# Detect distro
# ----------------------------
if [ -f /etc/debian_version ]; then
    DISTRO="debian"
elif [ -f /etc/arch-release ]; then
    DISTRO="arch"
elif [ -f /etc/fedora-release ]; then
    DISTRO="fedora"
else
    echo "[!] Unsupported distro"
    exit 1
fi

echo "[*] Detected: $DISTRO"

# ----------------------------
# User choice
# ----------------------------
echo ""
read -rp "Install type (minimal/full) [m/f]: " INSTALL_TYPE
echo ""

# ----------------------------
# Base package definitions
# ----------------------------

BASE_PKGS=(xorg git make gcc libxft libxinerama)

FULL_PKGS=(
    feh ffmpeg curl flameshot picom mpv
    alsa-utils pavucontrol kitty neofetch slock playerctl
    nemo arandr parcellite
    brightnessctl acpi
    wireless-tools xdotool
)

PERSONAL_PKGS=(
    qbittorrent keepassxc syncthing veracrypt
    brave-browser discord steam gparted timeshift vlc
)

# ----------------------------
# Distro mapping
# ----------------------------

case $DISTRO in
    debian)
        BASE_PKGS=(xorg git make gcc libxft-dev libxinerama-dev)
        FULL_PKGS=("${FULL_PKGS[@]}")
        ;;
    arch)
        BASE_PKGS=(xorg-server xorg-xinit git make gcc libxft libxinerama)
        FULL_PKGS=("${FULL_PKGS[@]/wireless-tools/wireless_tools}")
        ;;
    fedora)
        BASE_PKGS=(xorg-x11-server-Xorg xorg-x11-xinit git make gcc libXft-devel libXinerama-devel)
        FULL_PKGS=("${FULL_PKGS[@]}")
        ;;
esac

# ----------------------------
# Build package list
# ----------------------------

PKGS=("${BASE_PKGS[@]}")

if [[ "$INSTALL_TYPE" =~ ^[Ff]$ ]]; then
    PKGS+=("${FULL_PKGS[@]}")
fi

# ----------------------------
# Install packages
# ----------------------------

echo "[*] Installing packages..."

case $DISTRO in
    debian)
        sudo apt update
        sudo apt install -y "${PKGS[@]}"
        ;;
    arch)
        sudo pacman -Syu --noconfirm "${PKGS[@]}"
        ;;
    fedora)
        sudo dnf install -y "${PKGS[@]}"
        ;;
esac

# ----------------------------
# Setup config
# ----------------------------

CONFIG_DIR="$HOME/.config/dwm"

echo "[*] Copying config..."
mkdir -p "$CONFIG_DIR"
cp -r ./* "$CONFIG_DIR"

cd "$CONFIG_DIR"

# Apply ricing
if [ -d "rice" ]; then
    echo "[*] Applying ricing..."
    mv rice/kitty "$HOME/.config/" 2>/dev/null || true
    mv rice/picom.conf "$HOME/.config/" 2>/dev/null || true
fi

# ----------------------------
# Build DWM + dmenu
# ----------------------------

echo "[*] Building DWM..."

if [ -d "$CONFIG_DIR/dwm/dwm" ]; then
    cd "$CONFIG_DIR/dwm/dwm"
else
    echo "[!] Could not find dwm source"
    exit 1
fi

sudo make clean install

echo "[*] Building dmenu..."

if [ -d "$CONFIG_DIR/dwm/dmenu" ]; then
    cd "$CONFIG_DIR/dwm/dmenu"
else
    echo "[!] Could not find dmenu source"
    exit 1
fi

sudo make clean install

# ----------------------------
# Xinit setup
# ----------------------------

cd "$HOME"

echo "[*] Setting up start command..."

grep -qxF "alias startdwm='startx .xinitrcdwm'" ~/.bashrc || \
echo "alias startdwm='startx .xinitrcdwm'" >> ~/.bashrc

cat > ~/.xinitrcdwm << 'EOF'
exec dwm & wmpid=$!

sleep 3
$HOME/.config/dwm/rice/startupscript.sh

wait $wmpid
EOF

# ----------------------------
# Personal app suggestions
# ----------------------------

echo ""
echo "[*] Suggested personal apps (not installed):"
echo "${PERSONAL_PKGS[@]}"
echo ""

# ----------------------------
# Done
# ----------------------------

echo "[✓] Installation complete!"
echo "Run: startdwm"
