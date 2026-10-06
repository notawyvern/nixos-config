{
  self,
  inputs,
  ...
}:

{
  flake.homeModules.mangowc =
    { pkgs, config, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
      zen-browser = inputs.zen-browser.packages.${system}.default;

      # october 2026, mkOpacityHexColor generates ARGB,
      # not RGBA, opposing the docs. mango uses the latter.
      inherit (config.lib.stylix) mkHexColor colors;
      mkMangoColor = name: "${mkHexColor colors.${name}}ff";
    in
    {
      imports = [ inputs.mango.hmModules.mango ];
      wayland.windowManager.mango = {
        enable = true;
        package = pkgs-unstable.mango;
        settings = {
          # Window effect
          border_radius = 6;
          no_radius_when_single = 0;
          focused_opacity = "1.0";
          unfocused_opacity = "1.0";

          # Blur
          blur = 1;
          blur_layer = 1; # for panels and similar
          blur_optimized = 1; # cacheing

          # Animation Configuration(support type:zoom,slide)
          # tag_animation_direction: 1-horizontal,0-vertical
          animations = 1;
          layer_animations = 1;
          animation_type_open = "zoom";
          animation_type_close = "slide";
          animation_fade_in = 1;
          animation_fade_out = 1;
          tag_animation_direction = 1;
          zoom_initial_ratio = "0.2";
          zoom_end_ratio = "0.9";
          fade_in_begin_opacity = "0.5";
          fade_out_begin_opacity = "0.8";
          animation_duration_move = 550;
          animation_duration_open = 450;
          animation_duration_tag = 350;
          animation_duration_close = 800;
          animation_duration_focus = 0;
          animation_curve_open = "0.46,1.0,0.29,1";
          animation_curve_move = "0.46,1.0,0.29,1";
          animation_curve_tag = "0.46,1.0,0.29,1";
          animation_curve_close = "0.08,0.92,0,1";
          animation_curve_focus = "0.46,1.0,0.29,1";

          # Master-Stack Layout Setting
          new_is_master = 1;
          default_master_factor = "0.55";
          default_master_count = 1;
          smart_gaps = 0;

          # Overview Setting
          enable_hotarea = 0;
          overview_gap_inner = 5;
          overview_gap_outer = 30;

          # Misc
          no_border_when_single = 1;
          axis_bind_apply_timeout = 100;
          focus_on_activate = 1;
          sloppy_focus = 1;
          warp_cursor = 0;
          focus_cross_monitor = 0;
          focus_cross_tag = 0;
          enable_floating_snap = 0;
          snap_distance = 30;
          drag_tile_to_tile = 1;

          # keyboard
          repeat_rate = 25;
          repeat_delay = 600;
          numlock_on = 0;
          xkb_rules_layout = "br";

          # mouse
          mouse_natural_scrolling = 0;

          # Appearance
          gap_inner_horizontal = 9;
          gap_inner_vertical = 9;
          gap_outer_horizontal = 10;
          gap_outer_vertical = 10;
          scratchpad_width_ratio = "0.8";
          scratchpad_height_ratio = "0.9";
          border_px = 4;
          root_color = mkMangoColor "base00";
          border_color = mkMangoColor "base02";
          focus_color = mkMangoColor "base0D";
          maximized_screen_color = mkMangoColor "base0B";
          urgent_color = mkMangoColor "base09";
          scratchpad_color = mkMangoColor "base0E";
          global_color = mkMangoColor "base0C";
          overlay_color = mkMangoColor "base04";

          # layouts: tile,scroller,grid,deck,monocle,center_tile,vertical_tile,vertical_scroller
          tag_rule = [
            "id:1,layout_name:dwindle"
            "id:2,layout_name:dwindle"
            "id:3,layout_name:dwindle"
            "id:4,layout_name:dwindle"
            "id:5,layout_name:dwindle"
            "id:6,layout_name:dwindle"
            "id:7,layout_name:dwindle"
            "id:8,layout_name:dwindle"
            "id:9,layout_name:dwindle"
          ];

          bind = [
            # launchers
            "SUPER,w,spawn,${pkgs.tofi}/bin/tofi-drun"
            "SUPER,t,spawn,${pkgs.foot}/bin/foot"
            "SUPER,b,spawn,${zen-browser}/bin/zen-beta"
            "none,Print,spawn,${pkgs.wayshot}/bin/wayshot -c --encoding jpg"

            # power
            "SUPER+Shift,u,spawn,${pkgs.systemd}/bin/systemctl poweroff"
            "SUPER+Shift,r,spawn,${pkgs.systemd}/bin/systemctl reboot"

            # exit
            "ctrl+alt,space,quit"
            "SUPER,q,killclient,"

            # audio
            "none,XF86AudioRaiseVolume,spawn,${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            "none,XF86AudioLowerVolume,spawn,${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            "none,XF86AudioMute,spawn,${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

            # light
            "none,XF86MonBrightnessUp,spawn,${pkgs.brightnessctl}/bin/brightnessctl set 5%+"
            "none,XF86MonBrightnessDown,spawn,${pkgs.brightnessctl}/bin/brightnessctl set 5%-"

            # switch window focus
            "SUPER,h,focusdir,left"
            "SUPER,j,focusdir,down"
            "SUPER,k,focusdir,up"
            "SUPER,l,focusdir,right"

            # swap window
            "SUPER+SHIFT,h,exchange_client,left"
            "SUPER+SHIFT,j,exchange_client,down"
            "SUPER+SHIFT,k,exchange_client,up"
            "SUPER+SHIFT,l,exchange_client,right"

            # switch window status
            "SUPER,f,togglefullscreen,"

            # switch layout
            "SUPER,space,switch_layout"

            # tag switch
            "SUPER,1,view,1,0"
            "SUPER,2,view,2,0"
            "SUPER,3,view,3,0"
            "SUPER,4,view,4,0"
            "SUPER,5,view,5,0"
            "SUPER,6,view,6,0"
            "SUPER,7,view,7,0"
            "SUPER,8,view,8,0"
            "SUPER,9,view,9,0"
            "SUPER,0,toggleoverview"

            # places windows in tags
            "SUPER+shift,1,tag,1,0"
            "SUPER+shift,2,tag,2,0"
            "SUPER+shift,3,tag,3,0"
            "SUPER+shift,4,tag,4,0"
            "SUPER+shift,5,tag,5,0"
            "SUPER+shift,6,tag,6,0"
            "SUPER+shift,7,tag,7,0"
            "SUPER+shift,8,tag,8,0"
            "SUPER+shift,9,tag,9,0"

          ];

          mousebind = [
            # Mouse Button Bindings
            "SUPER,btn_left,moveresize,curmove"
            "SUPER,btn_right,moveresize,curresize"
          ];

          window_rule = [
            "is_floating:1,app_id:swayimg"
          ];
        };
        autostart_sh = ''
          ${config.mango-core.wlsunset}/bin/wlsunset-wrapper &
          ${pkgs.mako}/bin/mako &
          ${pkgs.swaybg}/bin/swaybg -i ${inputs.wallpaper} &
          ${pkgs.waybar}/bin/waybar &
        '';
      };
    };
}
