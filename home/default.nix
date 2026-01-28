{ username, pkgs, nvf, ... }:
let
  myCustomPkgs = import ../pkgs { inherit pkgs; };
in
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.${username} = { pkgs, ... }: {

    imports = [
      ./firefox
      ./vscode
      ./git
      ./nh
      ./bat
      ./nvf
      ./bash
      ./tmux
      ./wezterm
      ./zoxide
      nvf.homeManagerModules.default
    ];

    home.username = "${username}";
    home.homeDirectory = "/home/${username}";

    home.stateVersion = "26.05";

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
      vivid
      obsidian
      _1password-gui
    ])++ (with myCustomPkgs; [
    exegol
  ]);
  
  };
}

