{ pkgs, ... }:

let
  wallpaper = (pkgs.fetchFromGitHub
  {
    owner = "notawyvern";
    repo = "wallpapers";    
    rev = "994b29f29214e0e6dcf6d72332d2648f308b17b8";
    sha256 = "sha256-eVZR4DpG5fY6kZM6TJ/aa/07wtAAyYS0l0RSyZzqqe4=";
  } + "/fantasy/magical-land-japan-2.jpg");
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
