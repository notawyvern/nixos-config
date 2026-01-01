{ config, pkgs, ... }:
let
  gtk-theme = if (config.stylix.polarity == "dark") then ''"adw-gtk3-dark"'' else ''"adw-gtk3"'';
  cursor = "${config.stylix.cursor.name}";
  cursor-size = toString config.stylix.cursor.size;
in {
  # the users module declares theming resources
  users.users.greeter.packages = [ config.stylix.cursor.package pkgs.adw-gtk3 ];
  environment.etc = {
    "greetd/environments" = { text = "${pkgs.mangowc}/bin/mango"; };
    };

  services.greetd = {
    enable = true;
    restart = true;
    settings = {
      default_session = {
        command = 
          ''
          ${pkgs.coreutils}/bin/env GTK_THEME=${gtk-theme} XCURSOR_THEME=${cursor} XCURSOR_SIZE=${cursor-size} \
          ${pkgs.cage}/bin/cage -s -d -- ${pkgs.gtkgreet}/bin/gtkgreet
          '';
      };
    };
  };
}
 
