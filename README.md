🍚 DWM Precooked Rice

A fully pre-configured DWM (Dynamic Window Manager) setup with custom ricing, quality-of-life tweaks, and an automated install script.

Spin up a fresh machine → run one command → get your exact desktop.

✨ Features

Pre-patched and configured DWM

Includes dmenu

Custom ricing (themes, compositor, terminal)

Automated installation

Minimal setup required

Reproducible environment across machines

🚀 One-Line Install

Run this on a fresh Debian/Ubuntu-based system:

git clone https://github.com/Extocine/DWM-Precooked-Rice.git && cd DWM-Precooked-Rice && chmod +x install.sh && ./install.sh

Then start your environment:

startdwm
🖼 Screenshots

Add your screenshots to a /screenshots folder in the repo and they’ll display here.

![Desktop](screenshots/desktop.png)
![Terminal](screenshots/terminal.png)
![Floating Windows](screenshots/floating.png)

(Replace with your actual screenshots once uploaded)

📦 What Gets Installed

Core dependencies:

Xorg

git, make, gcc

Utilities:

feh – wallpapers

picom – compositor

kitty – terminal

flameshot – screenshots

mpv, ffmpeg – media

pavucontrol, alsa-utils – audio

brightnessctl, acpi – system controls

playerctl, wireless-tools

🧠 What the Script Does

Installs dependencies via apt

Moves configs into:

~/.config/dwm

Builds and installs:

dwm

dmenu

Applies ricing configs:

kitty

picom

startup scripts

Creates custom X session:

.xinitrcdwm

startdwm alias

Cleans up installation files

🖥 Usage

Start DWM with:

startdwm
🛠 Customization

All configs live here:

~/.config/dwm

Important files:

rice/startupscript.sh → autostart programs

picom.conf → compositor settings

kitty/ → terminal config

dwm/ → window manager source

🧪 Arch Linux (Optional)

A pacman install line is included (commented out) in the script.
Modify as needed for Arch-based systems.

⚠️ Notes

Intended for fresh installs

May overwrite existing configs

Assumes:

Bash shell

Standard home directory layout

💡 Philosophy

Rice once, deploy everywhere.

📄 License

Use freely and modify as needed.
