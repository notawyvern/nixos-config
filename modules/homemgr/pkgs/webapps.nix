{
  inputs,
  ...
}:
{
  flake.homeModules.webapps =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      webapp-run = inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        binName = "webapp-run";
        package = pkgs.firefox;
        flags."--new-window" = true;
      };
    in
    {
      # ublock origin install may hang the first launch.
      xdg.desktopEntries =
        lib.mapAttrs
          (name: url: {
            inherit name;
            exec = "${lib.getExe webapp-run} ${url}";
          })
          {
            ProtonMail = "https://mail.proton.me/";
            ChatGPT = "https://chatgpt.com/";
            GitHub = "https://github.com/";
            Spotify = "https://open.spotify.com/";
          };

      stylix.targets.firefox = {
        profileNames = [ "webapps" ];
        colorTheme.enable = true;
      };
      programs.firefox = {
        enable = true;
        configPath = "${config.xdg.configHome}/mozilla/firefox";
        profiles.webapps = {
          isDefault = true;
          userChrome = ''
            #TabsToolbar {
              visibility: collapse !important;
            }

            #PersonalToolbar {
              visibility: collapse !important;
            }

            #sidebar-box {
              visibility: collapse !important;
            }

            #main-window {
              -moz-appearance: none !important;
              background-color: transparent !important;
            }
          '';
          extensions = {
            force = true;
            packages = with pkgs.nur.repos.rycee.firefox-addons; [
              ublock-origin
              bitwarden
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
            "intl.locale.request" = "pt-BR";
            "extensions.autoDisableScopes" = 0; # auto enable adblock
            "signon.rememberSignons" = false; # no password signons
            "permissions.default.desktop-notification" = 1; # mako notifications

            # so css styling works
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

            # declutter
            "browser.shell.checkDefaultBrowser" = false;
            "privacy.userContext.enabled" = false;
            "browser.translations.enable" = false;
            "places.history.enabled" = false; # disables history
            "browser.startup.page" = 1; # don't open previous tabs
          };
        };
      };
    };
}
