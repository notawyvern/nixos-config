{ config, pkgs, pkgs-unstable, ... }: 


  let
    homepage = (pkgs.fetchFromGitHub
    {
      owner = "notawyvern";
      repo = "search";
      rev = "b9edf5df8530ead56f24ffdd55ee7ca7c98e6dd6";
      sha256 = "sha256-KmSorO+FT7z4RfS99ZD66NoQwIEC2HPh9ZzEyyhxdLU=";
    } + "/index.html");
  in {

  programs.qutebrowser = { 
    enable = true;
    package = pkgs-unstable.qutebrowser;
    settings = {

      # ui
      colors.webpage.darkmode.enabled = true;
      tabs.show = "multiple";
      url.default_page = homepage;
      url.start_pages = homepage;

      # general
      content.headers.accept_language = "pt-BR,pt;q=0.9";
      content.local_content_can_access_remote_urls = true; # so the homepage's search works

      content.blocking.adblock.lists = [
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
    searchEngines = {
      DEFAULT = "https://html.duckduckgo.com/html/search?q={}";
      ps = "https://presearch.com/search?q={}";
      bv = "https://search.brave.com/search?q={}";
      w = "https://grokipedia.com/search?q={}";
      r = "https://www.reddit.com/search?q={}";
      aw = "https://wiki.archlinux.org/?search={}";
      yt = "https://inv.nadeko.net/search?q={}";
      nix = "https://mynixos.com/search?q={}";
      ddg = "https://duckduckgo.com/?q={}";
    };
    quickmarks = {
      # fun
      anibunker = "https://anibunker.com/";
      anigo = "https://anigo.to/";
      betteranime = "https://betteranime.io/";
      weebcentral = "https://weebcentral.com/";
      scrobble = "https://listenbrainz.org/";
      youtube = "https://inv.nadeko.net/";
      mal = "https://myanimelist.net/";
      mangafire = "https://mangafire.to/";

      # utils
      urlvoid = "https://www.urlvoid.com/";
      waybackmachine = "https://web.archive.org/";
      annaarchive = "https://annas-archive.li/";
      YOPmail = "https://yopmail.com/en/";
      chatgpt = "https://duck.ai/";
      meet = "https://meet.jit.si/";

      # personal
      github = "https://github.com/";
      zapzap = "https://web.whatsapp.com/";
      email = "https://account.proton.me/mail";
      simplelogin = "https://app.simplelogin.io/auth/login";
      drive-cloud = "https://app.koofr.net/";
    };
  };
}
