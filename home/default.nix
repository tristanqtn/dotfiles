{ username, firefox-addons, pkgs, nvf, ... }:

let
  myCustomPkgs = import ../pkgs { inherit pkgs; };
in
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home-manager.users.${username} = { pkgs, ... }: {

    ########################################
    # Home config
    ########################################
    home.username = "${username}";
    home.homeDirectory = "/home/${username}";
    home.stateVersion = "26.05";

    ########################################
    # Imports
    ########################################
    imports = [
      ./avatar
      ./firefox
      ./vscode
      ./git
      ./nh
      ./bat
      ./nvf
      ./bash
      ./tmux
      ./fzf
      ./zoxide
      ./starship
      nvf.homeManagerModules.default
    ];

    ########################################
    # Home Packages
    ########################################
    home.packages = (with pkgs; [
      ripgrep
      discord
      python314
      python314Packages.pip
      python314Packages.pipx
      nodejs_25
      eza
      openvpn
      fd
      xclip
      vivid
      obsidian
      _1password-gui
    ])++ (with myCustomPkgs; [
    exegol
  ]);
  
  };
}

