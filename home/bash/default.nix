{ config, pkgs, lib, ... }:

{
  ###### Bash ######
  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      l = "${pkgs.eza}/bin/eza -lah --git --icons=always"; 
      ll = "${pkgs.eza}/bin/eza -lah --git --icons=always";
      ls = "${pkgs.eza}/bin/eza -G --icons";
      tree = "${pkgs.eza}/bin/eza -T --icons";
      gs = "git status";
      gl = "git log --oneline --graph --decorate";
      gd = "git diff";
      ga = "git add .";
      rebuild = "sudo nixos-rebuild switch";
      update = "sudo nixos-rebuild switch --upgrade";
      v = "nvim";
      co = "code .";
      ex = "xdg-open .";
    };

    initExtra = ''
      # Better history
      HISTSIZE=10000
      HISTFILESIZE=20000
      shopt -s histappend
      shopt -s cmdhist

      # Nicer defaults
      export EDITOR=nvim
      export VISUAL=nvim
      export PAGER=less
      export LESS=-R

      # Enable 24-bit color
      export COLORTERM=truecolor
    '';
  };

  ###### Starship ######
  programs.starship = {
    enable = true;
    enableBashIntegration = true;

    settings = {
      add_newline = true;

      format = lib.concatStrings [
        "$os"
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_status"
        "$nix_shell"
        "$character"
      ];

      character = {
        success_symbol = "[❯](bold purple)";
        error_symbol   = "[❯](bold red)";
      };

      os = {
        disabled = false;
        style = "bold purple";
        symbols = {
          NixOS = " ";
        };
      };

      username = {
        show_always = true;
        style_user = "bold pink";
      };

      hostname = {
        ssh_only = false;
        style = "bold pink";
      };

      directory = {
        style = "bold cyan";
        truncation_length = 3;
        truncate_to_repo = true;
      };

      git_branch = {
        symbol = " ";
        style = "bold green";
      };

      git_status = {
        style = "bold orange";
        format = "([$all_status$ahead_behind]($style) )";
      };

      nix_shell = {
        symbol = " ";
        style = "bold blue";
      };
    };
  };
}
