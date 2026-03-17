# 🍚 DWM Precooked Rice

A fully pre-configured **DWM (Dynamic Window Manager)** setup with custom ricing, quality-of-life tools, and a cross-distro install script.

> Spin up a fresh machine → run one command → get my exact desktop

---

## ✨ Features

* Pre-patched and configured **DWM**
* Includes **dmenu**
* Custom ricing (themes, compositor, terminal configs)
* Works on:

  * Debian / Ubuntu
  * Arch Linux
  * Fedora
* Minimal or full install options
* Reproducible environment across machines

---

## 🚀 One-Line Install

```bash
git clone https://github.com/Extocine/DWM-Precooked-Rice.git && cd DWM-Precooked-Rice && chmod +x install.sh && ./install.sh
```

Then start DWM in a TTy:

```bash
startdwm
```

---

## ⚙️ Install Options

During installation, you’ll be prompted:

### Minimal

Installs only what’s required to build and run DWM:

* Xorg
* git, make, gcc
* libxft, libxinerama

---

### Full

Installs everything:

* Media + utilities (`mpv`, `ffmpeg`, `feh`, `flameshot`)
* Compositor (`picom`)
* Audio (`alsa-utils`, `pavucontrol`)
* Terminal (`kitty`)
* System tools (`brightnessctl`, `acpi`)
* Status bar dependencies (`wireless-tools`, `xdotool`)
* QoL apps (`nemo`, `arandr`, `parcellite`, etc.)

---

## ⚠️ Notes

* Designed for **fresh installs**
* May overwrite existing configs
* Assumes:

  * Bash shell
  * Standard Linux home directory layout
  * A debian,arch,or rhel based OS
* A Vibe-Coded mess of an install script, though has been tested on several machines to ensure safety
