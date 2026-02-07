{ pkgs, ... }:

{
  ########################################
  # VS Code
  ########################################
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    profiles.default.extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      docker.docker
      pkief.material-icon-theme
      esbenp.prettier-vscode
      ms-python.python
      eamodio.gitlens
      redhat.vscode-yaml
      shd101wyy.markdown-preview-enhanced
    ];

    profiles.default.userSettings = {
      "chat.editor.fontFamily" = "FiraCode Nerd Font";
      "chat.editor.fontSize" = 20.0;
      "chat.fontFamily" = "DejaVu Sans";
      "debug.console.fontFamily" = "FiraCode Nerd Font";
      "debug.console.fontSize" = 20.0;
      "editor.fontFamily" = "FiraCode Nerd Font";
      "editor.fontSize" = 20.0;
      "editor.inlayHints.fontFamily" = "FiraCode Nerd Font";
      "editor.inlineSuggest.fontFamily" = "FiraCode Nerd Font";
      "editor.minimap.sectionHeaderFontSize" = 12.857142857142858;
      "markdown.preview.fontFamily" = "DejaVu Sans";
      "markdown.preview.fontSize" = 20.0;
      "notebook.markup.fontFamily" = "DejaVu Sans";
      "scm.inputFontFamily" = "FiraCode Nerd Font";
      "scm.inputFontSize" = 18.571428571428573;
      "screencastMode.fontSize" = 80.0;
      "terminal.integrated.fontSize" = 20.0;
      "workbench.colorTheme" = "Stylix";
      "workbench.iconTheme" = "material-icon-theme";
      "git.confirmSync" = "false";
    };
  };
}
