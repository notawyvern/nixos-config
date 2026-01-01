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

  programs.i3status-rust = {
    enable = true;
    bars.main = {
      settings.theme  = {
        theme = "native";
        overrides.separator = "  ";
      };
      icons = "material-nf";
      blocks = 
      [
        {
          block = "net";
          format = "$icon $signal_strength";
          inactive_format = "";
          missing_format = "";
        }
        {
          block = "sound";
          format = "$icon $volume";
          show_volume_when_muted = true;
        }
        {
          block = "time";
          format = "$icon $timestamp.datetime(locale:'pt_BR', f:'%d/%m/%Y, %H:%Mh') ";
        }
      ];
    };
  };

}
