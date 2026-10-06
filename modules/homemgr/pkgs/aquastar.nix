{
  inputs,
  ...
}:
{
  flake.homeModules.guiapps =
    {
      pkgs,
      lib,
      ...
    }:

    let
      wrappers = inputs.wrappers;
      system = pkgs.stdenv.hostPlatform.system;
      aquastar = inputs.aquastar.packages.${system}.aquastar-neo;

      artixgames = pkgs.symlinkJoin {
        name = "artixgames";
        paths = [
          (pkgs.makeDesktopItem {
            desktopName = "DragonFable";
            name = "dragonfable";
            exec = "${aquastar}/bin/aquastar-neo --aqw --no-launcher --game=dragonfable";
          })
          (pkgs.makeDesktopItem {
            desktopName = "AQWorlds";
            name = "aqworlds";
            exec = "${aquastar}/bin/aquastar-neo --aqw --no-launcher";
          })
        ];
      };

      AEtofi = wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.tofi;
        exePath = "${pkgs.tofi}/bin/tofi-drun";
        binName = "aegames";

        env = {
          # source previous symlinks for drun, using
          # these and not the default desktop files.
          XDG_DATA_DIRS = "${artixgames}/share";
          XDG_CACHE_HOME = "/tmp/tofi-artixgames"; # no conflicts with default cacheing
        };
      };
    in
    {
      xdg.desktopEntries.artixgames = {
        name = "Artix Games";
        exec = "${AEtofi}/bin/aegames";
      };
    };
}
