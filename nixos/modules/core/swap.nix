{ self, input, ... }:
{
  flake.nixosModules.zswap =
    { pkgs, ... }:
    {
      zramSwap = {
        memoryPercent = 100;
        enable = true;
      };
    };
}
