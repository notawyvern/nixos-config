{ self, inputs, ... }:
{
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  systems = [ "x86_64-linux" ];

  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.flake-parts.flakeModules.flakeModules

      {
        networking.hostName = "laptop";

        imports = with self.nixosModules; [
          # core modules
          hardware-laptop
          audio
          boot
          locale
          network
          packagemanager
          users
          zswap

          # global non-essential
          loginmanager
          services
          theming

          # home manager
          crhHomeManager
        ];
      }
    ];
  };
}
