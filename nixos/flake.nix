{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:nix-community/stylix/release-25.11";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
  };
  
  outputs = { self, nixpkgs, nixpkgs-unstable, stylix, home-manager }:
  
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

        ./syscore/network.nix
        ./syscore/audio.nix
        ./syscore/locale.nix
        ./syscore/swap.nix 
        ./syscore/boot.nix
        ./syscore/users.nix
        
        ./syspkgs/loginmgr.nix
        ./syspkgs/pkgmgr.nix
        ./syspkgs/modules.nix
        ./syspkgs/stylix.nix
        
        home-manager.nixosModules.home-manager {

          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit pkgs-unstable; };
        
          home-manager.users.crh.imports = [
            ./homemgr/home.nix # xdg related + enable HM
            ./homemgr/mangowc/mango.nix
            ./homemgr/mangowc/mango-core.nix
            
            /* package dependencies may also be
            included in cli/gui, even if they don't
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
