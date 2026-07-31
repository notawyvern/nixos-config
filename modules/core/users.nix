{ self, inputs, ... }:
{
  flake.nixosModules.users =
    { pkgs, config, ... }:
    {
      users.users.crh = {
        # a default password to not be
        # locked out of nixos. you should
        # change it with 'passwd crh'
        initialPassword = "ilovenix";
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
