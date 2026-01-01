{ config, pkgs, ... }:
{
  # the sway module declares configuration, the users one theming resources
  users.users.greeter.packages = [ config.stylix.cursor.package pkgs.adw-gtk3 ];
  programs.sway = { enable = true; package = null; extraPackages = []; };

  environment.etc = {
    "greetd/environments" = { text = "${pkgs.sway-unwrapped}/bin/sway"; };
    "greetd/compose.conf" = {
      text =
        ''
          exec "${pkgs.gtkgreet}/bin/gtkgreet -l; ${pkgs.sway-unwrapped}/bin/swaymsg exit"

          input "*" {
          xkb_layout br
          tap enabled
          }
          seat "*" {
          xcursor_theme "${config.stylix.cursor.name}" ${toString config.stylix.cursor.size}
          }

          include /etc/sway/config.d/*
        '';
      };
    };

  services.greetd = {
    enable = true;
    restart = true;
    settings = {
      default_session = {
        command = 
          ''
          ${pkgs.coreutils}/bin/env GTK_THEME=${if (config.stylix.polarity == "dark") then ''"adw-gtk3-dark"'' else ''"adw-gtk3"''} \
          ${pkgs.sway-unwrapped}/bin/sway -c /etc/greetd/compose.conf
          '';
      };
    };
  };
}
 
