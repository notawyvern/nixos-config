{ config, pkgs, ... }:
{
  environment.etc."ly/wayland-sessions/sway.desktop" = {
    text = with pkgs;
      ''
        [Desktop Entry]
        Name=Sway
        Comment=An i3-compatible Wayland compositor
        Exec=`${sway-unwrapped}/bin/sway "$@"`
        Type=Application
        DesktopNames=sway;wlroots
      '';
    mode = "444";
  };
  services.displayManager.ly = {
    enable = true;
    x11Support = false;
    settings = with pkgs; {
      animation = "matrix";
      bigclock = "en";
      waylandsessions = "/etc/ly/wayland-sessions";
    };
  };
}
 
