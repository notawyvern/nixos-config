{ pkgs, inputs, ... }:

{
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";
    image = inputs.wallpapers + "/fantasy/magical-land-japan-2.jpg";
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
