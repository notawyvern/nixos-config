# ❄️ NixOS Config

*A self-indulgent configuration made with careful attention.*

## Table of Contents
- [Introduction](#introduction)
- [Tree](#Tree)
- [Deploying](#deploying)
- [Cheatsheet](#cheatsheet)
    - [Shortcuts](#shortcuts)
    - [Software](#software)
    - [Wallpapers](#wallpapers)

https://github.com/user-attachments/assets/d02b4a61-11b9-4687-b84d-002247ab717e

## Introduction

This configuration is opinionated and can change. The documentation is meant for my future self and not to be accessible. Adopt it if you will, but it’s wiser to only study or replicate parts.

## Tree

```bash
.
├── assets
│   ├── mango-desk.jpg
│   └── zenbrowser.jpg
├── flake.lock
├── flake.nix
├── install.sh
├── LICENSE
├── modules
│   ├── core
│   │   ├── audio.nix
│   │   ├── boot.nix
│   │   ├── locale.nix
│   │   ├── network.nix
│   │   ├── pkgmgr.nix
│   │   ├── swap.nix
│   │   └── users.nix
│   ├── global
│   │   ├── loginmgr.nix
│   │   └── stylix.nix
│   ├── homemgr
│   │   ├── home.nix
│   │   ├── mangowc
│   │   │   ├── mango-core.nix
│   │   │   └── mango.nix
│   │   └── pkgs
│   │       ├── cli.nix
│   │       ├── gui.nix
│   │       ├── webapps.nix
│   │       └── zen-browser.nix
│   └── hosts
│       └── nixos
│           ├── configuration.nix
│           ├── disko.nix
│           └── hardware.nix
└── README.md
```

The NixOS config implements the dendritic pattern. Files can be freely moved in [modules](./modules/) without consequences.

In [core](./modules/core/) are features for a usable NixOS. User crh is declared but mutable. Brazilian Portuguese is enforced. 

The [global](./modules/global/) path locates extras. [loginmgr.nix](./modules/global/loginmgr.nix) partly references stylix, so better both be enabled.

At [homemgr](./modules/homemgr/) lots of heavily tweaked software is installed. It is needed for a GUI session and a must for a desktop PC. The main file [home.nix](./modules/homemgr/home.nix) sources its modules and configures xdg.

The [webapps](./modules/homemgr/pkgs/webapps.nix) rely on the Zen browser *webapps* profile, not on specialized modules. This is for uBlock Origin, as normal PWAs lack configurability.

## Deploying

> [!CAUTION]
> The script assumes internet access, GPT partition support, the firmware setup mode, and the x86_64 architecture. Follow the conditions, else your drive may be wiped without an OS.

1. Clone the repository and replace **"/dev/sda"** on [disko.nix](./modules/hosts/nixos/disko.nix) with your device. 
2. Run [install.sh](./install.sh) as root through a bootable image or NixOS installation. 
3. Change the temporary password for "crh", **ilovenix**, with your own.

## Cheatsheet

### Shortcuts

>[!NOTE]
>Click the waybar icons to configure network or audio through GUI.

The Windows or the Super key is used as Mod (modifier). The following shortcuts are the most important.

- **Arrow keys**: press during boot to select generations
- **Mod+b**: opens browser
- **Mod+w**: launches the tofi launcher
- **Mod+t**: opens the alacritty terminal
- **Mod+q**: closes the currently focused window
- **Mod+number**: changes the workspace
- **Ctrl+Alt+Space**: quits mangowc back to gtkgreet
- **Mod+Shift+u**: powers off
- **Mod+Shift+r**: reboots

### Software

- **Bootloader**: Limine
- **Wayland Compositor**: mangowm
- **Login Manager**: gtkgreet
- **Browser**: Zen Browser, uBO configured

**Most programs follow:**

> [!NOTE]
> These are the installed ones as of the time of writing and might be subject to change due to time and preferences.

* **IT**
    - VSCodium
    - git
    - Alacritty as a terminal emulator
    - Vim
    - fish (as in Home Manager)

* **FUN**
    - FreeTube
    - Ruffle

* **GENERAL**
    - mpv (uosc gui)
    - fastfetch
    - Zen Browser
    - Qalculate! GTK
    - featherpad
    - pcmanfm-qt
    - lxqt-archiver
    - lxtask
    - qpdfview
    - swayimg to view images

* **WEBAPPS**
    - Photopea
    - Spotify
    - ChatGPT
    - Proton Mail
    - Koofr Drive

### Wallpapers

[flake.nix](./flake.nix) references one. Change the source image to replace it. The line fetches a single image from my [wallpaper repo](https://github.com/notawyvern/wallpapers) to the /nix/store.
