# ❄️ NixOS Config

*Anybody is free to use, modify or look into the code!*

## Table of Contents
- [Overview](#overview)
- [Structure](#structure)
- [Installed Software](#installed-software)
- [Shortcut Cheatsheet](#shortcut-cheatsheet)
- [Wallpapers](#wallpapers)

## Overview

![Screenshot](assets/mango-desk.jpg)

Organized through the power of Home Manager, flakes plus modules, and GitHub referencing.

![Screenshot](assets/zenbrowser.jpg)

Bookmarks are declared. Stylix takes care of a cohesive theming. Vi mode on fish is enabled on Home Manager. And these things are just the tip of the iceberg.

## Structure

**NOTE**: By design, the repository has no hardware configuration. Remember to generate it.

- `nixos`: all declared configurations.
    - `flake.nix`: import-tree and flake-parts dendritic flake
        - `modules`: mostly dendritic configuration.
            - `core`: essential files for the installation.
                - **audio.nix**: pipewire
                - **boot.nix**: limine with secure boot, latest vanilla kernel
                - **locale.nix**: pt-br, America/Sao_Paulo timezone
                - **network.nix**: systemd-networkd, ethernet only
                - **pkgmgr.nix**: unfree packages enabled
                - **sourcing.nix**: sources nixos modules, configure systems
                - **swap.nix**: same zram amount as ram
                - **users.nix**: mutable, sudo-rs
            - `global`: non-essential files for all users.
                - **loginmgr.nix**: gtkgreet with cage and stylix theming
                - **services.nix**: global services
                - **stylix.nix**: cohesive theme for all users
            - `homemgr`: home manager.
                - **home.nix**: sources hm modules, configure xdg
                - `mangowc`: wayland compositor configuration.
                    - **mango-core.nix**: better mangowc ux with tofi menu, waybar
                    - **mango.nix**: flake-added options, personal keybindings, autostart binaries
                - `pkgs`: user installed packages.
                    - **cli.nix**: e.g., custom alacritty shell, colors for terminal
                    - **gui.nix**: many desktop applications
                    - **zen-browser.nix**: heavily tweaked browser: ublock origin, security improvements by default

## Installed Software

The majority of the packages are declared in [homemgr](./nixos/modules/homemgr) and [global](./nixos/modules/global). Cherry picking them might save some bandwidth and time when rebuilding NixOS.

The directory [pkgs](./nixos/modules/homemgr/pkgs) contain mostly software I find non-essential. Though it still has a few important ones. Most of them if not all follow:

* **IT**
    - VSCodium
    - git
    - Alacritty as a terminal emulator
    - VirtualBox
    - Vim
    - htop
    - fish (as in Home Manager)

* **FUN**
    - FreeTube
    - Spotify

* **GENERAL**
    - mpv (uosc gui)
    - fastfetch
    - KolourPaint
    - Zen Browser
    - Qalculate!'s GTK version
    - featherpad
    - pcmanfm-qt
    - pavucontrol-qt
    - lxqt-archiver
    - sioyek (a pdf viewer)
    - swayimg to view images

## Shortcut Cheatsheet

The Windows or the Super key is used as Mod (modifier). The following keys are the most important.

- **Arrow keys**: press during boot to select generations
- **Mod+b**: opens browser
- **Mod+w**: launches tofi menu (an app chooser alternative to dmenu)
- **Mod+t**: opens the alacritty terminal
- **Mod+q**: closes the currently focused window
- **Mod+number**: changes the workspace
- **Ctrl+Alt+Space**: quits mangowc back to gtkgreet
- **Mod+Shift+u**: powers off
- **Mod+Shift+r**: reboots

## Wallpapers

The file [stylix.nix](./nixos/modules/global/stylix.nix) references one. So change the line. The built-in code fetches my wallpaper repo and copies some really nice images to the /nix/store. If you're interested, [take a look](https://github.com/notawyvern/wallpapers).
