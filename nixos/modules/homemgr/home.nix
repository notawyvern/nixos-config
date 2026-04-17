{
  self,
  inputs,
  ...
}:

{
  flake.nixosModules.crhHomeManager =
    { pkgs, ... }:
    {
      imports = [ inputs.home-manager.nixosModules.default ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.crh = {
          imports = with self.homeModules; [
            home
            mangowc
            mango-core
            cliapps
            undeclared-gui
            declared-gui
            zenbrowser
          ];
        };
      };
    };

  flake.homeModules.home =
    { pkgs, config, ... }:
    {
      programs.home-manager.enable = true;
      home = {
        username = "crh";
        homeDirectory = "/home/crh";
        # Value of configuration compatible with Home Manager. To keep
        # it avoids breakage due to changes.
        #
        # No need to change it but, if you want to, read the release notes.
        stateVersion = "25.11";
      };

      xdg.userDirs = {
        enable = true;
        createDirectories = true;

        desktop = "${config.home.homeDirectory}/Área de Trabalho";
        documents = "${config.home.homeDirectory}/Documentos";
        download = "${config.home.homeDirectory}/Downloads";
        music = "${config.home.homeDirectory}/Música";
        pictures = "${config.home.homeDirectory}/Imagens";
        publicShare = "${config.home.homeDirectory}/Público";
        templates = "${config.home.homeDirectory}/Modelos";
        videos = "${config.home.homeDirectory}/Vídeos";
      };

      xdg = {
        desktopEntries = {
          htop = {
            name = "Htop";
            exec = with pkgs; "${alacritty}/bin/alacritty -e ${htop}/bin/htop";
            terminal = false;
          };
          vim = {
            name = "Vim";
            noDisplay = true;
          };
          gvim = {
            name = "gvim";
            noDisplay = true;
          };
          pcmanfm-qt-desktop-pref = {
            name = "desktop-pref";
            noDisplay = true;
          };
          cups = {
            name = "cups";
            noDisplay = true; # hides .desktop file for non-existent printer server
          };
        };
        mimeApps = {
          enable = true;
          defaultApplications = {
            "image/jpeg" = "swayimg.desktop";
            "image/png" = "swayimg.desktop";
          };
          associations.added = {
            "image/jpeg" = "swayimg.desktop";
            "image/png" = "swayimg.desktop";
          };
        };
      };
    };

}
