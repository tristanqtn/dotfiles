{ pkgs, ... }:
{
  programs.wezterm = {
    enable = true;                           # Enable WezTerm
    package = pkgs.wezterm;                  # Use the Nixpkgs WezTerm package

    enableBashIntegration = true;            # Optional: integrate with Bash prompt
    enableZshIntegration = false;            # Disable if using Bash

    # Extra configuration written to wezterm.lua
    extraConfig = ''
      local wezterm = require 'wezterm'

      return {
        font = wezterm.font("FiraCode Nerd Font"),   -- Nerd font for icons
        font_size = 14.5,
        enable_tab_bar = false,
        window_background_opacity = 0.95,
        color_scheme = "Dracula",
        default_cursor_style = "BlinkingBar",
        hide_tab_bar_if_only_one_tab = true,
        -- Launch TMUX automatically
        default_prog = { "/run/current-system/sw/bin/tmux", "new", "-A", "-s", "main" },
      }
    '';

    # Add custom color schemes in TOML format
    colorSchemes = {
      Dracula = {
        background = "#282a36";
        foreground = "#f8f8f2";
        cursor_bg = "#f8f8f2";
        cursor_fg = "#282a36";
        cursor_border = "#f8f8f2";
        selection_bg = "#44475a";
        selection_fg = "#f8f8f2";
        ansi = ["#000000" "#ff5555" "#50fa7b" "#f1fa8c" "#bd93f9" "#ff79c6" "#8be9fd" "#bbbbbb"];
        brights = ["#555555" "#ff5555" "#50fa7b" "#f1fa8c" "#bd93f9" "#ff79c6" "#8be9fd" "#ffffff"];
      };
    };
  };

}

