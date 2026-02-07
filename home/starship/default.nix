{ lib, ... }:

{
  ########################################
  # Starship
  ########################################
  programs.starship = {
    enable = true;
    enableBashIntegration = true;

    settings = {
      add_newline = true;

      # 2-line prompt: info above, action below
      format = lib.concatStrings [
        "$os"
        "$username"
        "$directory"
        "$git_branch"
        "$git_status"
        "$nix_shell"
        "\n$character"
      ];

      character = {
        success_symbol = "[❯](#BD93F9)";
        error_symbol = "[❯](#FF5555)";
      };

      directory = {
        style = "#8BE9FD";
        truncation_length = 3;
        truncate_to_repo = true;
      };

      git_branch = {
        symbol = " ";
        style = "#50FA7B";
      };

      git_status = {
        style = "#FFB86C";
        format = "([$all_status$ahead_behind]($style)) ";
      };

      nix_shell = {
        symbol = " ";
        style = "#6272A4";
      };

      os = {
        disabled = false;
        style = "#50FA7B";
        symbols = {
          NixOS = " ";
        };
      };

      username = {
        show_always = true;
        style_user = "#50FA7B";
      };

      hostname.ssh_only = true;
    };
  };
}
