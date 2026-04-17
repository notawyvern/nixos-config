{ self, inputs, ... }:
{
  flake.nixosModules.users =
    { pkgs, config, ... }:
    {
      # Define a user account. Don't forget to set a password with ‘passwd’.
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
