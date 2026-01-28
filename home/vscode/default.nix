{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      docker.docker
      pkief.material-icon-theme
      esbenp.prettier-vscode
      ms-python.python
    ];
  };

}
