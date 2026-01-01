{ config, pkgs, ... }:
{
  zramSwap = {
    memoryPercent = 100;	
    enable = true;
  };
}
