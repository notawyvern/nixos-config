{ self, inputs, ... }:

{
  flake.homeModules.cliapps =
    { pkgs, config, ... }:
    {
      programs.fastfetch = {
        enable = true;
        settings = {
          modules = [
            "title"
            "separator"
            "os"
            "host"
            "wm"
            "lm"
            "terminal"
            "bios"
            "locale"
            "uptime"
            "shell"
            "kernel"
            "cpu"
            "gpu"
            "break"
            "colors"
          ];
        };
      };

      programs.htop = {
        enable = true;
        settings = {
          tree_view = 1;
          show_program_path = 0;
        };
      };

      programs.git = {
        enable = true;
        settings = {
          user.name = "notawyvern";
          user.email = "218308804+notawyvern@users.noreply.github.com";
        };
      };

      # alternatives to gnu tools eg. ls
      programs = {
        bat.enable = true;
        eza = {
          enable = true;
          icons = "auto";
        };
      };

      programs.fish = {
        enable = true;
        binds = {
          "ctrl-e --mode insert".command = "accept-autosuggestion";
        };
        functions = {
          fish_greeting = "";
          fish_mode_prompt = "";
          fish_user_key_bindings = "fish_vi_key_bindings default";
          fish_prompt = "echo -s ''(set_color --bold green) [$USER@$hostname:$PWD]'$ '";
        };
        shellAliases = with pkgs; {
          # better outputs & tooling
          cat = "${bat}/bin/bat";
          less = "${bat}/bin/bat";
          diff = "${bat-extras.batdiff}/bin/batdiff";
          man = "${bat-extras.batman}/bin/batman";
          du = "${ncdu}/bin/ncdu";
          grep = "${ugrep}/bin/ugrep+";
          neofetch = "${fastfetch}/bin/fastfetch";

          # colored outputs
          df = "${grc}/bin/grc ${coreutils}/bin/df";
          uptime = "${grc}/bin/grc ${coreutils}/bin/uptime";
          free = "${grc}/bin/grc ${procps}/bin/free";
          ps = "${grc}/bin/grc ${procps}/bin/ps";
          lsblk = "${grc}/bin/grc ${util-linux}/bin/lsblk";
          ping = "${grc}/bin/grc ${inetutils}/bin/ping";
        };
      };

      programs.vim = {
        enable = true;
        defaultEditor = true;
        settings = {
          mouse = "a";
        };
      };
    };
}
