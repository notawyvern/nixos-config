{ self, inputs, ... }:
{
  flake.nixosModules.network =
    { pkgs, ... }:
    {
      # internet
      networking.networkmanager.enable = true;

      # firewall
      networking.nftables.enable = true; # modern iptables alternative
    };

}
