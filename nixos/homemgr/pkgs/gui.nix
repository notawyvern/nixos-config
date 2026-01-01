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
      vlc
      lxqt.pavucontrol-qt
      kdePackages.kolourpaint
    ]) ++
    (with pkgs-unstable;
    [ 
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

  # options in https://alacritty.org/config-alacritty.html
  programs.alacritty = {
    enable = true;
    settings = {
      env.SHELL = "${pkgs.fish}/bin/fish";
      selection.save_to_clipboard = true;
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
