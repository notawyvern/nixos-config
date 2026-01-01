{ config, pkgs, ... }:

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
      modules-right = [ "network" "wireplumber" ];

      "ext/workspaces".on-click = "activate";

      clock = {
        format = "{:%d/%m/%Y, %H:%M}h";
        tooltip-format = "{:L%e de %B, %A}";
      };

      network = {
        format = "{icon} {signalStrength}%";
        format-icons = [ "󰤟" "󰤢" "󰤥" "󰤨" ];
        format-disabled	= "";
        on-click = "${pkgs.iwgtk}/bin/iwgtk";
        tooltip = false;
      };

      wireplumber = {
        format = "{icon} {volume}%";
        format-icons = [ "" "" "" ];
        format-muted = " {volume}%";
        scroll-step = 5.0;
        on-click = "${pkgs.lxqt.pavucontrol-qt}/bin/pavucontrol-qt";
        on-click-right = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
      };
    };
  };
}
