{
  self,
  inputs,
  ...
}:

{
  flake.nixosModules.services =
    { pkgs, ... }:
    {
      services.gvfs.enable = true; # trash support
      programs.dconf.enable = true;
    };

  flake.homeModules.guiapps =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      ruffle-gl = pkgs.writeShellScriptBin "ruffle" ''
        export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [ pkgs.libGL ]}:$LD_LIBRARY_PATH
        exec ${pkgs.ruffle}/bin/ruffle "$@"
      '';
    in
    {
      # non-configured apps

      home.packages = with pkgs; [
        # file manager
        lxqt.pcmanfm-qt
        lxqt.lxqt-archiver
        p7zip # archiver's file extensions

        # desktop utils
        featherpad
        qpdfview
        qalculate-qt

        # media and virtualisation
        ruffle-gl
        spotify
        lxqt.pavucontrol-qt
        kdePackages.kolourpaint
      ];

      xdg.desktopEntries.ruffle = {
        # wraps ruffle for opengl support
        exec = "${ruffle-gl}/bin/ruffle";
        name = "Ruffle";
      };

      # configured apps

      xdg.configFile =
        let
          toml = pkgs.formats.toml { };
        in
        {
          ruffle = {
            target = "ruffle/bookmarks.toml";
            force = true;
            source = toml.generate "flash-projector.toml" {
              bookmark = [
                {
                  url = "https://aq.battleon.com/game/flash/Lore4652.swf";
                  name = "AdventureQuest";
                }

                {
                  url = "https://game.aq.com/game/gamefiles/Loader3.swf";
                  name = "AQWorlds";
                }

                {
                  url = "https://play.dragonfable.com/game/DFLoader.swf";
                  name = "DragonFable";
                }

                {
                  url = "https://play.mechquest.com/game/gamefiles/MQLoader4.swf";
                  name = "MechQuest";
                }
              ];
            };
          };
          featherpad = {
            target = "featherpad/fp.conf";
            force = true;
            source = toml.generate "text-editor.toml" {
              text.darkColorScheme = config.stylix.polarity == "dark";
            };
          };
          qpdfview = {
            target = "qpdfview/qpdfview.conf";
            force = true;
            source = toml.generate "pdfviewer.toml" {
              mainWindow.restorePerFileSettings = true;
            };
          };
          pcmanfm-qt = {
            target = "pcmanfm-qt/default/settings.conf";
            force = true;
            source = toml.generate "file-manager.toml" {
              System = {
                Archiver = "lxqt-archiver";
                Terminal = "alacritty";
              };
            };
          };
        };

      programs.mpv = {
        enable = true;
        scripts = with pkgs.mpvScripts; [ uosc ];
        scriptOpts = {
          uosc = {
            disable_elements = "idle_indicator";
            controls_persistency = "idle,paused";
          };
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

      programs.vscodium = {
        enable = true;
        package = pkgs.vscodium;
        mutableExtensionsDir = false;
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
    };
}
