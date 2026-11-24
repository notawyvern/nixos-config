# ❄️ NixOS Config

*A self-indulgent configuration made with careful attention.*

## Table of Contents
- [Vision](#vision)
    - [Design](#design)
    - [Tree](#tree)
- [Installer](#installer)
    - [Needs](#needs)
    - [Usage](#usage)
- [Cheatsheet](#cheatsheet)
    - [Tips](#tips)
    - [Shortcuts](#shortcuts)
    - [Software](#software)

https://github.com/user-attachments/assets/d02b4a61-11b9-4687-b84d-002247ab717e

## Vision

Principles guide the repository, yet none is absolute. Each is meant to add value, not an end by itself.

- Pure Nix whenever possible.
- Upstream first, KISS second, else workarounds.
- Owner-centric docs and configuration.

### Design

[flake-parts](https://github.com/hercules-ci/flake-parts) extends the flake, [import-tree](https://github.com/denful/import-tree) sources the tree. Combined, their dendritic pattern allows everything to be freely moved below [modules](./modules).

User crh is declared mutable. Brazilian Portuguese is enforced on locale and keyboard. Such matters follow the developer preferences.

Directory and file names are meaningful; [core](./modules/core/) for system-wide essentials, [mangowc](./modules/homemgr/mangowc/) for mango, etc. To learn, open each and read the comments.

Workarounds can be for the lack of better solutions. October 2026, [webapps](./modules/homemgr/pkgs/webapps.nix) e.g. rely on the Firefox webapps profile to use full uBlock Origin.

### Tree

```bash
.
├── flake.lock
├── flake.nix
└── modules
    ├── core
    │   ├── audio.nix
    │   ├── boot.nix
    │   ├── console.nix
    │   ├── locale.nix
    │   ├── network.nix
    │   ├── packagemanager.nix
    │   ├── users.nix
    │   └── zram.nix
    ├── global
    │   ├── eraseyourdarlings.nix
    │   ├── loginmanager.nix
    │   └── stylix.nix
    ├── homemgr
    │   ├── home.nix
    │   ├── mangowm
    │   │   ├── mango-core.nix
    │   │   └── mangowm.nix
    │   └── pkgs
    │       ├── artixgames.nix
    │       ├── cliapps.nix
    │       ├── guiapps.nix
    │       ├── qutebrowser.nix
    │       └── webapps.nix
    └── hosts
        └── nixos
            ├── configuration.nix
            ├── _disko.nix
            └── hardware.nix
```

## Installer

### Needs

> [!CAUTION]
> The installer requires some of these not to fail; missing others can leave you without an OS. Dual boot is unsupported.

- Internet
- A UEFI system in setup mode
- x86_64 architecture
- The Nix programming language

### Usage

Run this one-liner and answer prompts when asked:

```bash
git clone https://github.com/notawyvern/nixos-config &&
sudo bash nixos-config/install.sh
```

## Cheatsheet

### Tips

1. **nixos-rebuild** is disabled. Use [nh](https://github.com/nix-community/nh), a modern alternative, instead.
2. Waybar icons are minimal GUI settings. Press the brightness and audio keys if available.
3. [flake.nix](./flake.nix) fetches a single wallpaper from [this repository](https://github.com/notawyvern/wallpapers). Source another image to replace it.
4. [eyd](https://github.com/misuzu/eyd) mostly wipes root at boot to *erase your darlings*. See the latest ones in **/oldroot**.

### Shortcuts

The Windows or the Super key is used as Mod (modifier). The following shortcuts are the most important.

- **Arrow keys**: press during boot to select generations
- **Mod+B**: opens browser
- **Mod+W**: launches the tofi launcher
- **Mod+T**: opens the foot terminal
- **Mod+Q**: closes the currently focused window
- **Mod+number**: changes the workspace
- **Ctrl+Alt+Space**: quits mangowc back to Noctalia Greeter
- **Mod+Shift+U**: powers off
- **Mod+Shift+R**: reboots

### Software

- **Bootloader**: Limine
- **Wayland Compositor**: mangowm
- **Login Manager**: Noctalia Greeter
- **Browser**: qutebrowser

**Most programs follow:**

> [!NOTE]
> These are the installed ones as of the time of writing and can suddenly change.

* **IT**
    - VSCodium
    - git
    - foot as a terminal emulator
    - Vim
    - fish (with vi mode)

* **FUN**
    - FreeTube
    - Artix Games (tofi + Artix Ruffle fork)

* **GENERAL**
    - mpc-qt
    - fastfetch
    - qutebrowser
    - PhotoCraft
    - mako
    - Qalculate! (Qt)
    - featherpad
    - pcmanfm-qt
    - lxqt-archiver
    - qps
    - qpdfview
    - swayimg to view images

* **WEBAPPS**
    - Spotify
    - ChatGPT
    - GitHub
    - ProtonMail
