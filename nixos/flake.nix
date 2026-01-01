{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    mango.url = "github:mangowm/mango"; # wayland compositor
    mango.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:nix-community/stylix/release-25.11";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
  };
  
  outputs = { 
    self, 
    nixpkgs, 
    nixpkgs-unstable, 
    mango, 
    stylix, 
    home-manager 
  }:
  
  let
    system = "x86_64-linux";
    pkgs-unstable = import nixpkgs-unstable 
      {inherit system; config.allowUnfree = true;};
  in {
    
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        stylix.nixosModules.stylix
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
        
        home-manager.nixosModules.home-manager {

          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit pkgs-unstable; };
        
          home-manager.users.crh.imports = [
            mango.hmModules.mango
            ./homemgr/home.nix # xdg related + enable HM
            ./homemgr/mangowc/mango.nix
            ./homemgr/mangowc/mango-core.nix
            
            /* package dependencies may also be
            included in cli/gui .nix, even if they don't
            seem to match intended categories */
            ./homemgr/pkgs/qutebrowser.nix
            ./homemgr/pkgs/cli.nix
            ./homemgr/pkgs/gui.nix
          ];
        }
      ];
    };
  };

}
