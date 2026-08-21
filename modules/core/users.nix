{ self, inputs, ... }:
{
  flake.nixosModules.users =
    { pkgs, config, ... }:
    {
      users.users.crh = {
        isNormalUser = true;
        description = "crh";
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
      };

      security = {
        sudo.enable = false;
        sudo-rs = {
          enable = true;
          execWheelOnly = true;
        };
      };
    };
}
