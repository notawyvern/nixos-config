{
  flake.nixosModules.users = {
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
