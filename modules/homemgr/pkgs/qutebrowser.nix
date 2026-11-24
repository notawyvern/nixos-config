{ inputs, ... }:
{
  flake.homeModules.qutebrowser =
    {
      pkgs,
      ...
    }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
    in
    {
      programs.qutebrowser = {
        enable = true;
        package = pkgs-unstable.qutebrowser;
        settings = {
          tabs.show = "multiple";
          content = {
            headers.accept_language = "pt-BR,pt;q=0.9";
            local_content_can_access_remote_urls = true; # so the homepage's search works
            blocking.adblock.lists = [
              # basics
              "https://easylist.to/easylist/easylist.txt"
              "https://easylist.to/easylist/easyprivacy.txt"
              "https://easylist-downloads.adblockplus.org/easylistportuguese.txt"

              # spam/ads
              "https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt"
              "https://raw.githubusercontent.com/Yhonay/antipopads/master/hosts"
              "https://easylist-downloads.adblockplus.org/fanboy-notifications.txt"
              "https://raw.githubusercontent.com/Spam404/lists/master/adblock-list.txt"
              "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=adblockplus&showintro=0&mimetype=plaintext"
              "https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt"
              "https://easylist-downloads.adblockplus.org/fanboy-social.txt"
              "https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Hosts/GoodbyeAds.txt"
              "https://adaway.org/hosts.txt"

              # malware
              "https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/nocoin.txt"
              "https://raw.githubusercontent.com/DandelionSprout/adfilt/refs/heads/master/Dandelion%20Sprout's%20Anti-Malware%20List.txt"
              "https://someonewhocares.org/hosts/zero/hosts"
              "https://raw.githubusercontent.com/bongochong/CombinedPrivacyBlockLists/master/MiniLists/cpbl-abp-mini.txt"
              "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-porn/hosts"
            ];
          };
        };
        searchEngines = {
          DEFAULT = "https://duckduckgo.com/?q={}";
          ps = "https://presearch.com/search?q={}";
          bv = "https://search.brave.com/search?q={}";
          w = "https://grokipedia.com/search?q={}";
          aw = "https://wiki.archlinux.org/?search={}";
          yt = "https://inv.nadeko.net/search?q={}";
          nix = "https://mynixos.com/search?q={}";
        };
        quickmarks = {
          # fun
          anibunker = "https://anibunker.com/";
          anikoto = "https://anikoto.net/";
          animesonline = "https://animesonline.io/";
          youtube = "https://inv.nadeko.net/";
          mal = "https://myanimelist.net/";
          mangafire = "https://mangafire.to/";

          # utils
          urlvoid = "https://www.urlvoid.com/";
          waybackmachine = "https://web.archive.org/";
          annaarchive = "https://annas-archive.gl/";
          YOPmail = "https://yopmail.com/";
          zapzap = "https://web.whatsapp.com/";
          bitwarden = "https://vault.bitwarden.com/";
          cloud-drive = "https://app.koofr.net/app";
        };
      };
    };
}
