{
  flake.nixosModules.network = {
    # internet
    networking.networkmanager.enable = true;

    # firewall
    networking.nftables.enable = true; # modern iptables alternative
  };

}
