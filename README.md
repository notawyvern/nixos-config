# ❄️ NixOS Config

*A self-indulgent configuration made with careful attention.*

## Table of Contents
- [Introduction](#introduction)
- [Screenshots](#screenshots)
- [Tree](#Tree)
- [Deploying](#deploying)
- [Cheatsheet](#cheatsheet)
    - [Shortcuts](#shortcuts)
    - [Software](#software)
    - [Wallpapers](#wallpapers)

## Introduction

>[!WARNING]
> This configuration is opinionated and prone to change. The documentation is meant for my future self and not to be accessible. You may adopt it, but it’s wiser to study or copy only parts of it.

It is a quite personal project. Feel free to take a look or do what you need with it. By reading thoroughly, you won't bother with problems already solved.

## Screenshots

![Screenshot](assets/mango-desk.jpg)

![Screenshot](assets/zenbrowser.jpg)

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
│   │       └── zen-browser.nix
│   └── hosts
│       └── nixos
│           ├── configuration.nix
│           ├── disko.nix
│           └── hardware.nix
└── README.md
```

The configuration implements the dendritic pattern. Files can be freely moved in [modules](./modules/) without consequences.

In [core](./modules/core/) are features for a usable NixOS. User crh is declared but mutable. Brazilian Portuguese is enforced. 

The [global](./modules/global/) path locates extras. [loginmgr.nix](./modules/global/loginmgr.nix) partly references stylix, so better both be enabled.

At [homemgr](./modules/homemgr/) lots of heavily tweaked software is installed. It is needed for a GUI session and a must for a desktop PC. The main file [home.nix](./modules/homemgr/home.nix) sources its modules and configures xdg.

## Deploying

> [!CAUTION]
> The script assumes internet access, GPT partition support, the firmware setup mode, the x86_64 architecture, and a */dev/sda* drive. Follow the conditions, else your drive may be wiped without an OS.

Clone the repository and run [install.sh](./install.sh) as root to install NixOS through a bootable image. The default password for "crh" is **ilovenix**. It is highly recommended to change it with *passwd crh*.

## Cheatsheet

### Shortcuts

>[!NOTE]
>Click the waybar icons to configure network or audio through GUI.

The Windows or the Super key is used as Mod (modifier). The following shortcuts are the most important.

- **Arrow keys**: press during boot to select generations
- **Mod+b**: opens browser
- **Mod+w**: launches tofi menu (an app chooser alternative to dmenu)
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
- **Browser**: Zen Browser

**Most programs follow:**

> [!NOTE]
> These are the installed ones as of the time of writing and might be subject to change due to time and preferences.

* **IT**
    - VSCodium
    - git
    - Alacritty as a terminal emulator
    - Vim
    - htop
    - fish (as in Home Manager)

* **FUN**
    - FreeTube
    - Spotify
    - Ruffle

* **GENERAL**
    - mpv (uosc gui)
    - fastfetch
    - KolourPaint
    - Zen Browser
    - Qalculate!'s GTK version
    - featherpad
    - pcmanfm-qt
    - lxqt-archiver
    - qpdfview
    - swayimg to view images

### Wallpapers

[flake.nix](./flake.nix) references one. Change the source image to replace it. The line fetches a single image from my [wallpaper repo](https://github.com/notawyvern/wallpapers) to the /nix/store.