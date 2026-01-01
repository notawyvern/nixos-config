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

  # night light color temperature
  services.wlsunset = {
    enable = true;
    sunset = "17:30";
    sunrise = "5:00";
    temperature.day = 6500;
    temperature.night = 2800;
  };

  programs.i3status = {
    enable = true;
    enableDefault = false;
    general = {
      separator = "";
      output_format = "i3bar";
      colors = true;
      interval = 5;
    };
    modules = {
      "wireless wlan0" = {
        position = 1;
        settings = {
          format_up = " %quality ";
          format_down = "";
          };
        };
      "battery 1" = {
        position = 2;
        settings = {
          format = "%status %percentage";
          format_down = "";
          last_full_capacity = true;
          integer_battery_capacity = true;
          low_threshold = 40;
          threshold_type = "percentage";
          status_chr = "󰂏";
          status_bat = "󰂌";
          status_full = "󰁹";
        };
      };
      "tztime localdate" = {
        position = 4;
        settings = {
          format = "  %d/%m/%Y";
        };
      };
      "tztime localtime" = {
        position = 5;
        settings = {
          format = "  %H:%Mh ";
        };
      };
    };
  };
}
