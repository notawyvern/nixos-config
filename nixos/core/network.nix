{ config, pkgs, ... }:
{
  networking = {
    hostName = "nixos"; # Define your hostname.
    dhcpcd.wait = "background";
  };

}
