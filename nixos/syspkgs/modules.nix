{ config, lib, pkgs, ... }:
{
  # trash for file manager
  services.gvfs.enable = true;

  # low level
  programs.dconf.enable = true;
  services.dbus.implementation = "broker";

  /* disable the nscd service,
  aimed at servers and not desktops */
  services.nscd.enable = false;
  system.nssModules = lib.mkForce [];
}
 
