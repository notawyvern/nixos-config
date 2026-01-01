{ config, pkgs, ... }:

{
  home = {
    username = "crh";
    homeDirectory = "/home/crh";
  };
    
  xdg = {
    desktopEntries = {
      htop = {
        name = "Htop";
        exec = with pkgs; "${alacritty}/bin/alacritty -e ${htop}/bin/htop";
        terminal = false;
      };
      vim = {
        name = "Vim";
        noDisplay = true;
      };
      gvim = {
        name = "gvim";
        noDisplay = true;
      };
      pcmanfm-qt-desktop-pref = {
        name = "desktop-pref";
        noDisplay = true;
      };
      cups = {
        name = "cups";
        noDisplay = true; # hides .desktop file for non-existent printer server
      };
    };
      mimeApps = {
        enable = true;
        defaultApplications = {
          "image/jpeg" = "swayimg.desktop";
          "image/png" = "swayimg.desktop";
        };
        associations.added = {
          "image/jpeg" = "swayimg.desktop";
          "image/png" = "swayimg.desktop";
        };
      };
    };

  # enables home manager
  programs.home-manager.enable = true;

  # Value of configuration compatible with Home Manager. To keep
  # it avoids breakage due to changes.
  #
  # No need to change it but, if you want to, read the release notes.
  home.stateVersion = "25.11";
}
