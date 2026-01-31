{ ... }:

{
  ########################################
  # NixOS Helper 
  ########################################
  programs.nh = {
    enable = true;
    clean = { 
        enable = true;
        extraArgs = "--keep-since 4d --keep 3";
    };
    flake = /home/drachh/dotfiles;
    homeFlake = /home/drachh/dotfiles; 
    osFlake = /home/drachh/dotfiles;
  };
}