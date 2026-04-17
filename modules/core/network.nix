{ self, inputs, ... }:
{
  flake.nixosModules.network =
    { pkgs, ... }:
    {
      # internet
      networking = {
        hostName = "nixos"; # Define your hostname.
        networkmanager.enable = true;
      };

      # firewall
      networking.nftables.enable = true; # modern iptables alternative
    };

}
