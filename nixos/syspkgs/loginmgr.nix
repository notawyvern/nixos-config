{ config, pkgs, ... }:
{
  # the sway module declares configuration, the users one theming resources
  users.users.greeter.packages = [ config.stylix.cursor.package pkgs.adw-gtk3 ];
  programs.sway = { enable = true; package = null; extraPackages = []; };

  environment.etc = {
    "greetd/environments" = { text = "${pkgs.sway-unwrapped}/bin/sway"; };
    "greetd/kiosk.conf" = {
      text =
        ''
          exec "${pkgs.gtkgreet}/bin/gtkgreet; ${pkgs.sway-unwrapped}/bin/swaymsg exit"

          # this allows switching tty, gtkgreet -l does not
          for_window [app_id="gtkgreet"] fullscreen enable

          input "*" {
          xkb_layout br
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
          ${pkgs.sway-unwrapped}/bin/sway -c /etc/greetd/kiosk.conf
          '';
      };
    };
  };
}
 
