{ self, inputs, ... }:
{
  flake.nixosModules.zswap =
    { pkgs, ... }:
    {
      zramSwap = {
        enable = true;

        # if the ram is greater than or
        # equal to 4 GB, then it is 8 GB,
        # else it is two times the ram.
        memoryPercent = 200;
        memoryMax = 8000000000;
      };
    };
}
