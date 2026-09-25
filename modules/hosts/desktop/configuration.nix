{ self, inputs, ... }:
{
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  systems = [ "x86_64-linux" ];

  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [

      {
        networking.hostName = "desktop";
      }

      inputs.flake-parts.flakeModules.flakeModules

      # core modules
      self.nixosModules.hardware-desktop
      self.nixosModules.audio
      self.nixosModules.boot
      self.nixosModules.locale
      self.nixosModules.network
      self.nixosModules.packagemanager
      self.nixosModules.users
      self.nixosModules.zswap

      # global non-essential
      self.nixosModules.loginmanager
      self.nixosModules.services
      self.nixosModules.theming

      # home manager
      self.nixosModules.crhHomeManager

    ];
  };
}
