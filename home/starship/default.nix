{ ... }:
{
programs.starship = {
  enable = true;                         # Enable Starship
  package = pkgs.starship;               # Use Nixpkgs package

  enableBashIntegration = true;          # Enable Bash prompt
  enableZshIntegration = false;          # Disable Zsh if using Bash
  enableFishIntegration = false;         # Disable Fish
  enableInteractive = true;              # Only interactive shells

  # Path where Starship config will be written, relative to home
  configPath = ".config/starship.toml";

  # TOML settings
  settings = {
    # Prompt format
    format = """
      $all
      $character
    """;

    # Customize the prompt character
    character = { 
      success_symbol = "➜ "; 
      error_symbol   = "✗ "; 
      use_symbol_for_status = true;
      style = "bold green";
    };

    # Git branch module
    [git_branch]
    symbol = " "
    style = "bold purple"

    # Git status module
    [git_status]
    style = "bold red"

    # Directory module
    [directory]
    style = "cyan"

    # Time module
    [time]
    style = "bright-black"
    disabled = false

    # Line breaks
    [line_break]
    disabled = false

    # Jobs module
    [jobs]
    style = "bold yellow"

    # Battery module
    [battery]
    style = "bold green"
  };
};

}