{ self, inputs, ... }:
{
  flake.nixosModules.loginmanager =
    { config, pkgs, ... }:
    let
      stylix = config.stylix;
      stylix-colors = config.lib.stylix.colors.withHashtag;
      system = pkgs.stdenv.hostPlatform.system;
      pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
    in
    {

      imports = with inputs; [
        noctalia-greeter.nixosModules.default
      ];

      services.displayManager = {
        sessionPackages = [ pkgs-unstable.mango ];
        noctalia-greeter = {
          enable = true;
          package = pkgs-unstable.noctalia-greeter;
          settings = {
            user.default = "crh";
            appearance = {
              scheme = "Synced";
              scheme_selector_position = "hidden";
              hide_logo = true;
              palette = with stylix-colors; {
                primary = base0D;
                on_primary = base00;
                secondary = base0E;
                on_secondary = base00;
                tertiary = base0C;
                on_tertiary = base00;
                error = base08;
                on_error = base00;
                surface = base00;
                on_surface = base05;
                surface_variant = base01;
                on_surface_variant = base04;
                outline = base03;
                shadow = base00;
                hover = base0C;
                on_hover = base00;
              };
            };
            cursor = {
              path = "${stylix.cursor.package}/share/icons";
              theme = "${stylix.cursor.name}";
              size = stylix.cursor.size;
            };
          };
        };
      };
    };
}
