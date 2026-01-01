{ config, lib, pkgs, ... }:
{
  # trash for file manager
  services.gvfs.enable = true;

  # completion for programs in zsh 
  environment.pathsToLink = [ "/share/zsh" ];

  # low level
  programs.dconf.enable = true;
  services.dbus.implementation = "broker";

  /* disable the nscd service,
  aimed at servers and not desktops */
  services.nscd.enable = false;
  system.nssModules = lib.mkForce [];
  
  # gui for bluetooth  
  services.blueman.enable = true;
 
}
 
