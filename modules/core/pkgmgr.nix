{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.packagemanager =
    { pkgs, ... }:
    let
      nixos-config = "github:notawyvern/nixos-config";
    in
    {
      # Nix User Repository
      imports = [ inputs.nur.modules.nixos.default ];

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      nix = {
        channel.enable = false;
        settings = {
          experimental-features = [
            "nix-command"
            "flakes"
          ];
        };
      };

      system = {
        tools.nixos-rebuild.enable = false; # replaced by nh
        autoUpgrade = {
          enable = true;
          flake = nixos-config;
          operation = "boot";
          randomizedDelaySec = "30min";
        };
      };

      programs.nh = {
        enable = true;
        flake = nixos-config;

        /*
          avoids an indefinite number of
          generations due to auto updating
        */
        clean = {
          enable = true;
          dates = "daily";
          extraArgs = "--keep 4 --optimise";
        };
      };

      # Pinned stateful data for compatibility;
      # doesn't determine version of packages.
      #
      # To safely change it read the release notes.
      system.stateVersion = "25.11"; # Did you read the comment?
    };

}
