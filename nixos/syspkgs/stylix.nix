{ pkgs, ... }:

let
  wallpaper = (pkgs.fetchFromGitHub
  {
    owner = "notawyvern";
    repo = "wallpapers";    
    rev = "c354359b4f20677acca6cb794dadd9302efe9721";
    sha256 = "sha256-z83FDpMM1PiGyyPE+t87XnqE/DNBi0wAk9F+WX2GlA8=";
  } + "/sci-fi/redsky-neon.jpg");
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
