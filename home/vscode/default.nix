{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;

    extensions = with pkgs.vscode-extensions; [
      # Nix support
      bbenoist.nix

      # Docker support
      docker.docker

      # Material icons
      pkief.material-icon-theme

      esbenp.prettier-vscode     # Code formatting
      ms-python.python           # Python support if you code in Python
    ];
  };
}
