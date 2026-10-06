{
  inputs,
  ...
}:
{
  flake.nixosModules.packagemanager =
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
    };
}
