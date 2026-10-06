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
      ruffle-artix = inputs.aquastar.packages.${system}.ruffle-artix; # ruffle fork by artix entertainment

      artixgames = pkgs.symlinkJoin {
        name = "artixgames";
        paths = [
          (pkgs.makeDesktopItem {
            desktopName = "AdventureQuest";
            name = "aqoriginal";
            exec = "${lib.getExe ruffle-artix} https://aq.battleon.com/game/flash/Lore4652.swf";
          })
          (pkgs.makeDesktopItem {
            desktopName = "AQWorlds";
            name = "aqworlds";
            exec = "${lib.getExe ruffle-artix} https://game.aq.com/game/gamefiles/Loader4.swf";
          })
          (pkgs.makeDesktopItem {
            desktopName = "DragonFable";
            name = "dragonfable";
            exec = "${lib.getExe ruffle-artix} https://play.dragonfable.com/game/DFLoader.swf";
          })
          (pkgs.makeDesktopItem {
            desktopName = "MechQuest";
            name = "mechquest";
            exec = "${lib.getExe ruffle-artix} https://play.mechquest.com/game/gamefiles/MQLoader4.swf";
          })
        ];
      };

      artixgames-tofi = wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.tofi;
        exePath = "${pkgs.tofi}/bin/tofi-drun";
        binName = "artixgames-tofi";

        env = {
          # use previously symliked drun sources,
          # not the default desktop files.
          XDG_DATA_DIRS = "${artixgames}/share";
          XDG_CACHE_HOME = "/tmp/tofi-artixgames"; # avoids conflicts by cache
        };
      };
    in
    {
      xdg.desktopEntries.artixgames = {
        name = "Artix Games";
        exec = "${artixgames-tofi}/bin/artixgames-tofi";
      };
    };
}
