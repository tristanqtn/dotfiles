{ username, ... }:
{
  imports = [
    ./firefox
    ./vscode
    ./git
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.${username} = { pkgs, ... }: {
    home.username = "${username}";
    home.homeDirectory = "/home/${username}";

    home.stateVersion = "26.05";

    programs.git.enable = true;

    home.packages = with pkgs; [
      ripgrep
      discord
    ];
  
  };
}

