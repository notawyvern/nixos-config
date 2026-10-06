{ self, inputs, ... }:
{
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  systems = [ "x86_64-linux" ];

  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.flake-parts.flakeModules.flakeModules

      {
        networking.hostName = "nixos";

        /*
          Pinned stateful data for compatibility; doesn't determine
          system version. To safely change it read the release notes.
        */
        system.stateVersion = "25.11"; # Did you read the comment?

        imports = with self.nixosModules; [
          # core modules
          hardware-desktop
          audio
          boot
          locale
          network
          console
          packagemanager
          users
          zswap

          # global non-essential
          loginmanager
          services
          stylix

          # home manager
          crhHomeManager
        ];
      }
    ];
  };
}
