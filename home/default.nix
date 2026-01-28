{ username, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.${username} = { pkgs, ... }: {

    imports = [
      ./firefox
      ./vscode
      ./git
      ./nh
    ];

    home.username = "${username}";
    home.homeDirectory = "/home/${username}";

    home.stateVersion = "26.05";

    home.packages = with pkgs; [
      ripgrep
      discord
      python314
      python314Packages.pip
      python314Packages.pipx
      nodejs_25
      #exegol

    ];
  
  };
}

