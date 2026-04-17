{ self, inputs, ... }:
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
