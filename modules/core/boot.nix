{ self, inputs, ... }:
{
  # Bootloader.
  flake.nixosModules.boot =
    { pkgs, ... }:
    {
      boot = {
        plymouth.enable = true;
        kernelParams = [ "quiet" ];
        kernelPackages = pkgs.linuxPackages_latest;
        loader = {
          timeout = 1;
          limine = {
            enable = true;
            secureBoot.enable = true;
            extraConfig = "quiet: yes"; # hides limine, shown by arrow press
          };
        };
      };
    };
}
