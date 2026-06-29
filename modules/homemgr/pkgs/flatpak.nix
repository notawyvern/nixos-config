{
  self,
  inputs,
  ...
}:

{
  flake.nixosModules.services =
    { pkgs, ... }:
    {
      # nix-flatpak needs what follows
      services.flatpak.enable = true;
      xdg.portal = with pkgs; {
        enable = true;
        extraPortals = [ xdg-desktop-portal-gtk ];
        config.common.default = [ "gtk" ];
      };
    };
  flake.homeModules.flatpak =
    { pkgs, config, ... }:
    {
      imports = with inputs; [
        nix-flatpak.homeManagerModules.nix-flatpak
      ];
      services.flatpak = {
        enable = true;
        uninstallUnmanaged = true;
        update.auto.enable = true;
        packages = [
          "rs.ruffle.Ruffle"
        ];
      };
    };
}
