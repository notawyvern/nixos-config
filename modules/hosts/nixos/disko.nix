{ self, inputs, ... }:
{
  flake.nixosModules.partitioning =
    {
      config,
      lib,
      ...
    }:
    {
      # set stateful data
      system.stateVersion = "25.11";

      # define architecture
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      imports = [ inputs.disko.nixosModules.disko ];
      disko.devices = {
        disk = {
          main = {
            device = "/dev/sda";
            type = "disk";
            content = {
              type = "gpt";
              partitions = {
                BOOT = {
                  size = "1G";
                  type = "EF00";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [ "umask=0077" ];
                  };
                };
                ROOT = {
                  size = "100%";
                  content = {
                    type = "filesystem";
                    format = "ext4";
                    mountpoint = "/";
                  };
                };
              };
            };
          };
        };
      };
    };
}
