{ pkgs, lib, ... }:

{
  ########################################
  # Alacritty Theming
  ########################################
  programs.alacritty = {
    enable = true;

    settings = {
      colors = {
        primary = {
          background = lib.mkForce "#282a36";
          foreground = lib.mkForce "#f8f8f2";
          bright_foreground = lib.mkForce "#ffffff";
        };

        cursor = {
          text = lib.mkForce "CellBackground";
          cursor = lib.mkForce "CellForeground";
        };

        vi_mode_cursor = {
          text = lib.mkForce "CellBackground";
          cursor = lib.mkForce "CellForeground";
        };

        search = {
          matches = {
            foreground = lib.mkForce "#44475a";
            background = lib.mkForce "#50fa7b";
          };
          focused_match = {
            foreground = lib.mkForce "#44475a";
            background = lib.mkForce "#ffb86c";
          };
        };

        hints = {
          start = {
            foreground = lib.mkForce "#282a36";
            background = lib.mkForce "#f1fa8c";
          };
          end = {
            foreground = lib.mkForce "#f1fa8c";
            background = lib.mkForce "#282a36";
          };
        };

        line_indicator = {
          foreground = lib.mkForce "None";
          background = lib.mkForce "None";
        };

        footer_bar = {
          foreground = lib.mkForce "#282a36";
          background = lib.mkForce "#f8f8f2";
        };

        selection = {
          text = lib.mkForce "CellForeground";
          background = lib.mkForce "#44475a";
        };

        normal = {
          black = lib.mkForce "#21222c";
          red = lib.mkForce "#ff5555";
          green = lib.mkForce "#50fa7b";
          yellow = lib.mkForce "#f1fa8c";
          blue = lib.mkForce "#bd93f9";
          magenta = lib.mkForce "#ff79c6";
          cyan = lib.mkForce "#8be9fd";
          white = lib.mkForce "#f8f8f2";
        };

        bright = {
          black = lib.mkForce "#6272a4";
          red = lib.mkForce "#ff6e6e";
          green = lib.mkForce "#69ff94";
          yellow = lib.mkForce "#ffffa5";
          blue = lib.mkForce "#d6acff";
          magenta = lib.mkForce "#ff92df";
          cyan = lib.mkForce "#a4ffff";
          white = lib.mkForce "#ffffff";
        };
      };

      # Font configuration
      font = {
        normal = {
          family = lib.mkForce "FiraCode Nerd Font";
          style = lib.mkForce "Regular";
        };
        bold = {
          family = lib.mkForce "FiraCode Nerd Font";
          style = lib.mkForce "Bold";
        };
        italic = {
          family = lib.mkForce "FiraCode Nerd Font";
          style = lib.mkForce "Italic";
        };
        bold_italic = {
          family = lib.mkForce "FiraCode Nerd Font";
          style = lib.mkForce "Bold Italic";
        };
        size = lib.mkForce 11.0;
      };

      window = {
        opacity = lib.mkForce 0.95;
        padding = {
          x = lib.mkForce 8;
          y = lib.mkForce 8;
        };
        decorations = lib.mkForce "none";
        startup_mode = lib.mkForce "Windowed";
        dynamic_title = lib.mkForce true;
      };

      # Scrolling
      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      # Cursor
      cursor = {
        style = {
          shape = "Beam";
          blinking = "Off";
        };
        unfocused_hollow = true;
      };

      # Bell
      bell = {
        animation = "EaseOutExpo";
        duration = 0;
        color = "#ffffff";
      };

      # Mouse
      mouse = {
        hide_when_typing = false;
      };

      # Hints (URL clicking)
      hints = {
        enabled = [
          {
            regex = ''(ipfs:|ipns:|magnet:|mailto:|gemini:|gopher:|https:|http:|news:|file:|git:|ssh:|ftp:)[^\u0000-\u001f\u007f-\u009f<>"\\s{-}\\^⟨⟩`]+'';
            command = "xdg-open";
            post_processing = true;
            mouse = {
              enabled = true;
              mods = "None";
            };
            binding = {
              key = "U";
              mods = "Control|Shift";
            };
          }
        ];
      };
    };
  };
}
