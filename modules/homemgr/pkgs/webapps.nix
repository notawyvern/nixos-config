{
  self,
  inputs,
  ...
}:

{

  flake.homeModules.zenbrowser =
    { pkgs, ... }:
    {
      programs.zen-browser = {
        profiles.webapps = {
          id = 1;
          extensions = {
            force = true;
            packages = with pkgs.nur.repos.rycee.firefox-addons; [
              ublock-origin
            ];
            settings."uBlock0@raymondhill.net" = {
              force = true;
              settings = {
                selectedFilterLists = [
                  # all non-regional filters
                  "ublock-badlists"
                  "ublock-filters"
                  "ublock-badware"
                  "ublock-privacy"
                  "ublock-unbreak"
                  "ublock-quick-fixes"
                  "ublock-experimental"
                  "adguard-generic"
                  "adguard-mobile"
                  "easylist"
                  "adguard-spyware-url"
                  "block-lan"
                  "easyprivacy"
                  "urlhaus-1"
                  "curben-phishing"
                  "adguard-cookies"
                  "ublock-cookies-adguard"
                  "fanboy-cookiemonster"
                  "ublock-cookies-easylist"
                  "adguard-social"
                  "fanboy-social"
                  "fanboy-thirdparty_social"
                  "adguard-popup-overlays"
                  "adguard-mobile-app-banners"
                  "adguard-other-annoyances"
                  "adguard-widgets"
                  "easylist-annoyances"
                  "easylist-chat"
                  "fanboy-ai-suggestions"
                  "easylist-newsletters"
                  "easylist-notifications"
                  "ublock-annoyances"
                  "dpollock-0"
                  "plowe-0"
                  # pt + spa filters
                  "spa-1"
                ];
              };
            };
          };
          settings = {
            "intl.locale.requested" = "pt-BR"; # profile language
            "zen.window-sync.enabled" = false; # tab separation for webapps
            "extensions.autoDisableScopes" = 0; # auto enable adblock

            # disables ui
            "zen.view.compact.enable-at-startup" = true;
            "zen.view.compact.show-sidebar-and-toolbar-on-hover" = false;
            "zen.theme.content-element-separation" = 0;

            # declutter
            "browser.shell.checkDefaultBrowser" = false;
            "privacy.userContext.enabled" = false;
            "zen.welcome-screen.seen" = true;
            "browser.translations.enable" = false;
            "places.history.enabled" = false; # disables history
            "browser.startup.page" = 1; # don't open previous tabs
          };
        };
      };
    };
  flake.homeModules.guiapps =
    {
      pkgs,
      ...
    }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      zen-browser = inputs.zen-browser.packages.${system}.default;
      webapp-run = "${zen-browser}/bin/zen-beta -P webapps --new-window";
    in
    {
      /*
        web apps may take a while to
        load the first time, since ublock
        origin is being installed.
      */
      xdg.desktopEntries = {
        photopea = {
          name = "Photopea";
          exec = "${webapp-run} https://www.photopea.com/";
          icon = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/photopea/photopea/7a3ba2e0b0f559f98129d195675a9be6dcec6e3d/logo.svg";
            hash = "sha256-UqzvoMaMaBiQmpVKzPZJMwDI2VWeNuYmr2plaAM1b8I=";
          };
        };
        protonmail = {
          name = "Proton Mail";
          exec = "${webapp-run} https://mail.proton.me/";
          icon = pkgs.fetchurl {
            url = "https://www.svgrepo.com/show/331550/protonmail.svg";
            hash = "sha256-TT91yFKQxGPxkH5E/QWRFs/xLrZQULxkuGrMjl3EI+U=";
          };
        };
        koofr = {
          name = "Koofr Drive";
          exec = "${webapp-run} https://app.koofr.net/app";
          icon = pkgs.fetchurl {
            url = "https://www.svgrepo.com/show/331458/koofr.svg";
            hash = "sha256-emihupzSIRvvcL1PAFt9NUfqrNHNzUoPQunICRGSRm8=";
          };
        };
        chatgpt = {
          name = "ChatGPT";
          exec = "${webapp-run} https://chatgpt.com/";
          icon = pkgs.fetchurl {
            url = "https://www.svgrepo.com/show/235199/chip-ai.svg";
            hash = "sha256-MnCZdi0rIg/dWKYYjnrQ8h9ddPPBxlzYz5dYLAQVgeU=";
          };
        };
        /*
          log in with the password to keep spotify
          credentials. this issue is server-side.
        */
        spotify = {
          name = "Spotify";
          exec = "${webapp-run} https://open.spotify.com/";
          icon = pkgs.fetchurl {
            url = "https://www.svgrepo.com/show/55272/spotify.svg";
            hash = "sha256-fMKNoY9D/OgJK9J+HI9IN6EKWNIh8uZJDaE+MCYBX7E=";
          };
        };
      };
    };
}
