{ config, pkgs, ...}:
{
  # Bootloader.
  boot.loader = {
    limine.enable = true;
    timeout = 1;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

}
