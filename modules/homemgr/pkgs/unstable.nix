{
  self,
  inputs,
  ...
}:

{

  flake.homeModules.unstableapps =
    { pkgs, config, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      pkgs-unstable = inputs.unstable.legacyPackages.${system};
    in
    {
      # non-configured apps
      home.packages = with pkgs-unstable; [
        spotube
        yt-dlp-light # allows its backend for spotube
      ];

      # meant to be configured elsewhere
      programs.freetube.package = pkgs-unstable.freetube;
    };
}
