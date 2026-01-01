{ config, lib, pkgs, ... }:
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    channel.enable = false;
    settings = {
      auto-optimise-store = true; 
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  # Safer to leave value at the first install's version number. 
  # Read docs before changing it ( eg. man configuration.nix )
  system.stateVersion = "25.11"; # Did you read the comment?

}
 
