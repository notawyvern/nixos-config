{ config, pkgs-unstable, pkgs, ... }:

{
  wayland.windowManager.sway = {
    systemd = {
      enable = true;
      dbusImplementation = "broker";
    };
    enable = true;
    checkConfig = false;
    config = rec {
      modifier = "Mod4";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      menu = "${pkgs.tofi}/bin/tofi-drun";
      defaultWorkspace = "workspace number 1";

      # vi bindings
      left = "h";
      down = "j";
      up = "k";
      right = "l";

      window = {
        titlebar = false;
        commands = [
          {
            command = "floating enable";
            criteria.app_id = "qalculate-gtk";
          }
          {
            command = "floating enable";
            criteria.app_id = "swayimg";
          }
        ];
      };
      gaps = {
        inner = 13;
        smartGaps = true;
        smartBorders = "on";
      };
      input."*" = {
        xkb_layout = "br";
        tap = "enabled";
      };
      keybindings = {
        # launching
        "${modifier}+b" = "exec ${pkgs-unstable.qutebrowser}/bin/qutebrowser";
        "${modifier}+t" = "exec ${terminal}";
        "${modifier}+w" = "exec ${menu}";
        "${modifier}+Shift+e" = "exec ${pkgs.wleave}/bin/wleave -x -l ${config.xdg.configHome}/wlogout/layout";

        # workspaces
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";

        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";

        # windowing
        "${modifier}+${left}" = "focus left";
        "${modifier}+${down}" = "focus down";
        "${modifier}+${up}" = "focus up";
        "${modifier}+${right}" = "focus right";

        "${modifier}+Ctrl+${left}" = "move workspace to output left";
        "${modifier}+Ctrl+${down}" = "move workspace to output down";
        "${modifier}+Ctrl+${up}" = "move workspace to output up";
        "${modifier}+Ctrl+${right}" = "move workspace to output right";

        "${modifier}+Shift+${left}" = "move left";
        "${modifier}+Shift+${down}" = "move down";
        "${modifier}+Shift+${up}" = "move up";
        "${modifier}+Shift+${right}" = "move right";

        "${modifier}+space" = "floating toggle";

        "Ctrl+Alt+Space" = "exec ${pkgs.sway-unwrapped}/bin/swaymsg exit";
        "${modifier}+f" = "fullscreen";
        "${modifier}+q" = "kill";

        # audio
        "XF86AudioRaiseVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

        # video
        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set +5%";
        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
        "Print" = "exec ${pkgs.wayshot}/bin/wayshot -c -e jpg";
      };
      
      bars = [(
        { 
          statusCommand = "${pkgs.i3status}/bin/i3status";
          position = "top";
        }
        // config.stylix.targets.sway.exportedBarConfig
        )];
        startup = with pkgs; [
          {
            # workaround for services not restarting after ly exit
            command = ''${systemd}/bin/systemctl --user restart "*".target'';
            always = true;
          }
        ];
    };
    };
}
