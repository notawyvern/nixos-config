{ config, pkgs, ... }:
{
  networking = {
    hostName = "nixos"; # Define your hostname.
    useDHCP = false;
    useNetworkd = true;
  };

  systemd.network = {
    enable = true;
    networks."10-ethernet" = {
      matchConfig.Name = "en*";
      networkConfig.DHCP = "yes";
    };
  };

}
