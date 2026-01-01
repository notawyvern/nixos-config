{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    mango.url = "github:mangowm/mango"; # wayland compositor
    mango.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:nix-community/stylix/release-25.11";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    wallpapers.url = "github:notawyvern/wallpapers";
    wallpapers.flake = false;
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      mango,
      zen-browser,
      nur,
      stylix,
      wallpapers,
    }@inputs:

    let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hardware-configuration.nix

          ./core/audio.nix
          ./core/boot.nix
          ./core/locale.nix
          ./core/network.nix
          ./core/pkgmgr.nix
          ./core/swap.nix
          ./core/users.nix

          ./global/loginmgr.nix
          ./global/services.nix
          ./global/stylix.nix

          home-manager.nixosModules.home-manager
          {

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              inherit pkgs-unstable;
            };

            home-manager.users.crh.imports = [
              ./homemgr/home.nix # xdg related + enable HM
              ./homemgr/mangowc/mango.nix
              ./homemgr/mangowc/mango-core.nix

              /*
                package dependencies may also be
                included in cli/gui .nix, even if they don't
                seem to match intended categories
              */
              ./homemgr/pkgs/zen-browser.nix
              ./homemgr/pkgs/cli.nix
              ./homemgr/pkgs/gui.nix
            ];
          }
        ];
      };
    };

}
