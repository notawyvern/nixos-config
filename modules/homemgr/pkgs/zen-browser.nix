{
  inputs,
  pkgs,
  ...
}:
{
  flake.homeModules.zenbrowser =
    { pkgs, ... }:
    {
      imports = [ inputs.zen-browser.homeModules.default ];
      programs.zen-browser = {
        enable = true;
        profiles.default = {
          isDefault = true;
          search = {
            force = true;
            default = "brave";
            engines = {
              brave = {
                name = "Brave";
                urls = [
                  { template = "https://search.brave.com/search?q={searchTerms}"; }
                  {
                    template = "https://search.brave.com/api/suggest?q={searchTerms}";
                    type = "application/x-suggestions+json";
                  }
                ];
                iconMapObj."16" =
                  "https://cdn.search.brave.com/serp/v3/_app/immutable/assets/favicon-16x16.nT_pLL7v.png";
                definedAliases = [ "@brave" ];
              };
            };
          };
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
            # fixes audio issues on my hardware
            "media.default_volume" = "0.002";
            "media.volume_scale" = "0.002";

            # usability
            "browser.search.suggest.enabled" = true;
            "browser.urlbar.showSearchSuggestionsFirst" = false; # history before query

            # browser language
            "intl.locale.requested" = "pt-BR";

            # security
            "dom.security.https_only_mode" = true;
            "network.trr.mode" = 2; # dns over https

            # declutter
            "browser.shell.checkDefaultBrowser" = false;
            "privacy.userContext.enabled" = false;
            "zen.welcome-screen.seen" = true;
            "browser.translations.enable" = false;
            "browser.startup.page" = 1; # don't open previous tabs
            "extensions.autoDisableScopes" = 0; # auto enable extensions
          };
          bookmarks = {
            force = true;
            settings = [
              {
                name = "Pessoal";
                toolbar = true;
                bookmarks = [
                  {
                    name = "GitHub";
                    url = "https://github.com/";
                  }
                  {
                    name = "Koofr Drive";
                    url = "https://app.koofr.net/";
                  }
                  {
                    name = "Proton Mail";
                    url = "https://account.proton.me/mail";
                  }
                  {
                    name = "SimpleLogin";
                    url = "https://app.simplelogin.io/auth/login";
                  }
                ];
              }
              {
                name = "Animes";
                toolbar = true;
                bookmarks = [
                  {
                    name = "AniBunker";
                    url = "https://anibunker.com/";
                  }
                  {
                    name = "AnimesOnline";
                    url = "https://animesonline.io/";
                  }
                  {
                    name = "Anroll";
                    url = "https://www.anroll.cc/";
                  }
                  {
                    name = "MAL";
                    url = "https://myanimelist.net/";
                  }
                  {
                    name = "MangaFire";
                    url = "https://mangafire.to/";
                  }
                ];
              }
              {
                name = "Utilidades";
                toolbar = true;
                bookmarks = [
                  {
                    name = "AI Chat";
                    url = "https://duck.ai/?q=DuckDuckGo&ia=chat";
                  }
                  {
                    name = "Anna’s Archive";
                    url = "https://annas-archive.gl/";
                  }
                  {
                    name = "ArchWiki";
                    url = "https://wiki.archlinux.org/";
                  }
                  {
                    name = "Jitsi Meet";
                    url = "https://meet.jit.si/";
                  }
                  {
                    name = "URLVoid";
                    url = "https://www.urlvoid.com/";
                  }
                  {
                    name = "Wayback Machine";
                    url = "https://web.archive.org/";
                  }
                  {
                    name = "YOPmail";
                    url = "https://yopmail.com/en/";
                  }
                ];
              }
            ];
          };
        };
      };
      stylix.targets.zen-browser.profileNames = [ "default" ];
    };
}
