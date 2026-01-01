{ pkgs, ... }:

let
  wallpaper = (pkgs.fetchFromGitHub
  {
    owner = "notawyvern";
    repo = "wallpapers";
    rev = "bf660f36c3d74925d578a30245621e9e17cc3343";
    sha256 = "sha256-CQOKgEvCbppnbzbVKFeV2JDVKPoU2FX3ZWvpI/JAGFI=";
  } + "/magical-land-japan.jpg");
in 
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";
    image = wallpaper;
    polarity = "dark";
    icons = {
      enable = true;
      dark = "breeze-dark";
      light = "breeze";
      package = pkgs.kdePackages.breeze-icons;
    };
    cursor = {
      package = pkgs.adwaita-icon-theme;
      size = 24;
      name = "Adwaita";
    };

    fonts = with pkgs.nerd-fonts; {
    sizes = {
      popups = 22;
      applications = 13;
      desktop = 15;
      terminal = 16;
    };
    serif = {
      package = departure-mono;
      name = "DepartureMono Nerd Font";
    };

    sansSerif = {
      package = departure-mono;
      name = "DepartureMono Nerd Font";
    };

    monospace = {
      package = departure-mono;
      name = "DepartureMono Nerd Font Mono";
    };

    emoji = {
      package = departure-mono;
      name = "DepartureMono Nerd Font";
    };
  };
};
}
