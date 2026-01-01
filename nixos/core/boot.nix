{ config, pkgs, ... }:
{
  # Bootloader.
  boot.loader = {
    timeout = 1;
    limine = {
      enable = true;
      secureBoot.enable = true;
      extraConfig = "quiet: yes"; # hides limine, shown by arrow press
    };
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

}
