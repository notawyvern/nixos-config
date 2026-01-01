{ config, pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      modules = [
        "title" "separator" "os" "host" "wm" "lm"
        "terminal" "bios" "locale" "uptime" "shell" 
        "kernel" "cpu" "gpu" "break" "colors"
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

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    settings = {
      user.name = "notawyvern";
      user.email = "218308804+notawyvern@users.noreply.github.com";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
      strategy = [ "history" ];
    };
    completionInit = "autoload -U compinit && compinit -C && bindkey '^E' end-of-line";
    defaultKeymap = "viins";
    shellAliases = {
      neofetch = "fastfetch";
      ls = "ls --color=auto";
      vdir = "vdir --color=auto";
      dir = "dir --color=auto";
    };
    setOptions = [ "nocaseglob" ];
    sessionVariables = {
      PROMPT="%F{green}%B[%n@%b%f%k%F{green}%B%m:%b%f%k%F{green}%B%~]%b%f%k ";
    };
  };

  programs.vim = {
    enable = true;
    defaultEditor = true;
    settings = {
      mouse = "a";
    };
    };
  
}
