{
  flake.nixosModules.console = {
    services.kmscon = {
      enable = true;
      useXkbConfig = true;
    };
  };
}
