{ config, pkgs, ... }:
{
  networking = {
    hostName = "nixos"; # Define your hostname.
    dhcpcd.wait = "background";
    wireless.iwd.enable = true;
  };

  # bluetooth configuration
  hardware.bluetooth.enable = true;

}
