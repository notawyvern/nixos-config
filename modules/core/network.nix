{
  flake.nixosModules.network = {
    networking.networkmanager.enable = true;
    networking.nftables.enable = true; # modern iptables firewall alternative
  };
}
