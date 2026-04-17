{ config, pkgs, ... }:

{
  flake.homeModules.mango-core =
    { pkgs, ... }:
    {
      # menu to run programs
      programs.tofi = {
        enable = true;
        settings = {
          history = false;
          prompt-text = ''" "'';
          hide-cursor = true;
          drun-launch = true;
        };
      };

      programs.waybar = {
        enable = true;
        settings.bar = {
          layer = "top";
          position = "top";

          modules-left = [ "ext/workspaces" ];
          modules-center = [ "clock" ];
          modules-right = [
            "network"
            "wireplumber"
          ];

          "ext/workspaces".on-click = "activate";

          clock = {
            format = "{:%d/%m/%Y, %H:%M}h";
            tooltip = false;
          };

          network = with pkgs; {
            format-disconnected = "󰪎 offline";
            format-ethernet = " {ifname}";
            format-wifi = "{icon} {signalStrength}%";
            format-icons = [
              "󰤟"
              "󰤢"
              "󰤥"
              "󰤨"
            ];
            on-click = "${networkmanagerapplet}/bin/nm-connection-editor";
            tooltip = false;
          };

          wireplumber = {
            format = "{icon} {volume}%";
            format-icons = [
              ""
              ""
              ""
            ];
            format-muted = " {volume}%";
            tooltip = false;
            scroll-step = 5.0;
            on-click = "${pkgs.lxqt.pavucontrol-qt}/bin/pavucontrol-qt";
            on-click-right = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          };
        };
      };
    };
}
