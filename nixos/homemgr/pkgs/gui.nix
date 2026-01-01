{ config, pkgs, pkgs-unstable, ... }:

{

  /* manual configurations */
  imports = [ ({pkgs, ...}: {
    home.packages = (with pkgs; 
    [ 
      # file manager
      lxqt.pcmanfm-qt
      lxqt.lxqt-archiver

      # desktop utils
      featherpad
      iwgtk
      qalculate-gtk

      # media and virtualisation
      virtualboxKvm
      upscayl
      vlc
      kdePackages.kolourpaint
    ]) ++
    (with pkgs-unstable;
    [ 
      # flash player alternative
      ruffle

      # music streaming
      spotube
      yt-dlp # allows its backend for spotube
    ]);
  }) ];

  xdg.configFile = {
    featherpad = {
      target = "featherpad/fp.conf"; force = true;
      text = with config.stylix;
        if (polarity == "dark") then "[text]"+"\n"+"darkColorScheme = true"
        else "[text]"+"\n"+"darkColorScheme = false";
    };
    pcmanfm-qt = {
      target = "pcmanfm-qt/default/settings.conf"; force = true;
      text =
        ''
          [System]
          Archiver=lxqt-archiver
          Terminal=alacritty
        '';
    };
    ruffle-preferences = {
      target = "ruffle/preferences.toml";
      text =
        ''
        gamemode = "on"
        open_url_mode = "allow"
        '';
    };
    ruffle-bookmarks = {
      target = "ruffle/bookmarks.toml"; force = true;
      text =
        ''
        [[bookmark]]
        url = "https://game.aq.com/game/gamefiles/Loader3.swf"
        name = "AQW"

        [[bookmark]]
        url = "https://play.dragonfable.com/game/DFLoader.swf"
        name = "DragonFable"

        [[bookmark]]
        url = "https://aq.battleon.com/game/flash/Lore4652.swf"
        name = "AdventureQuest"

        [[bookmark]]
        url = "https://play.mechquest.com/game/gamefiles/MQLoader4.swf"
        name = "MechQuest"
        '';
    };
  };

  /* declared modules */

  programs.sioyek = {
    enable = true;
    config = with config.stylix; {
      "font_size" = toString fonts.sizes.applications;
      "status_bar_font_size" = toString fonts.sizes.desktop;
      "ui_font" = fonts.monospace.name;
      "default_dark_mode" = 
        if (polarity == "dark") then "1" else "0";
    };
    bindings = {
      toggle_dark_mode = "<C-i>";
      next_page = "J";
      previous_page = "K";
    };

  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      selection.save_to_clipboard = true;
      terminal.shell.program = "${pkgs.zsh}/bin/zsh";
    };
  };

  programs.swayimg = {
    enable = true;
    settings = {
      "keys.viewer" = {
        h = "prev_file";
        l = "next_file";
      };
      general = {
        mode = "viewer";
        size = "900,700";
      };
      list.all = "yes";
    };
  };
  
  programs.freetube = {
    enable = true;
    package = pkgs-unstable.freetube;
    settings = {
      autoplayVideos = false;
      hideHeaderLogo = true;
      hideLiveChat = true;
      hidePopularVideos = true;
      hideRecommendedVideos = true;
      hideSubscriptionsShorts = true;
      hideChannelShorts = true;
      hideTrendingVideos = true;
      checkForUpdates = false;
      checkForBlogPosts = false;
      playNextVideo = false;
      useDeArrowTitles = true;
      useDeArrowThumbnails = true;
      useRssFeeds = true;
      useSponsorBlock = true;
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    profiles.default = { 
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        ms-ceintl.vscode-language-pack-pt-br
        github.vscode-pull-request-github
      ];
      userSettings = {
        "git.autofetch" = true;
      };
    };
  };

}
