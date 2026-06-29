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
            flatpak
            cliapps
            guiapps
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
        # Pinned stateful data for compatibility;
        # doesn't determine version of packages.
        #
        # To safely change it read the release notes.
        stateVersion = "25.11"; # Did you read the comment?
      };

      xdg.userDirs = {
        enable = true;
        setSessionVariables = true;
        createDirectories = true;

        desktop = "${config.home.homeDirectory}/Área de Trabalho";
        documents = "${config.home.homeDirectory}/Documentos";
        download = "${config.home.homeDirectory}/Downloads";
        music = "${config.home.homeDirectory}/Música";
        pictures = "${config.home.homeDirectory}/Imagens";
        publicShare = "${config.home.homeDirectory}/Público";
        templates = "${config.home.homeDirectory}/Modelos";
        videos = "${config.home.homeDirectory}/Vídeos";
        projects = null;
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
