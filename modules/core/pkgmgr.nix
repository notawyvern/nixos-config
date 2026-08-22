{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.packagemanager =
    { pkgs, ... }:
    {
      # Nix User Repository
      imports = [ inputs.nur.modules.nixos.default ];

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      nix = {
        channel.enable = false;
        settings = {
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
        };
      };

      # Auto upgrade
      system.autoUpgrade = {
        enable = true;
        flake = "github:notawyvern/nixos-config";
        operation = "boot";
        randomizedDelaySec = "30min";
      };

      /*
        avoids an indefinite number of
        generations due to auto updating
      */
      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };

      # Pinned stateful data for compatibility;
      # doesn't determine version of packages.
      #
      # To safely change it read the release notes.
      system.stateVersion = "25.11"; # Did you read the comment?
    };

}
