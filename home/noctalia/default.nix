{ pkgs, inputs, config, ... }:

{
  ########################################
  # Noctalia Shell
  ########################################
  imports = [
    inputs.noctalia.homeModules.default
  ];

  # Configure Noctalia shell
  programs.noctalia-shell = {
    enable = true;
    
    # Enable systemd service to start on boot
    systemd.enable = true;
    
    # Basic settings - you can customize these
    settings = {
      bar = {
        position = "top";
        density = "default";
        showCapsule = true;
        widgets = {
          left = [
            { id = "Launcher"; }
            { id = "Clock"; }
            { id = "ActiveWindow"; }
          ];
          center = [
            { id = "Workspace"; }
          ];
          right = [
            { id = "Tray"; }
            { id = "Battery"; }
            { id = "Volume"; }
            { id = "ControlCenter"; }
          ];
        };
      };
      
      general = {
        # Avatar is handled in ../avatar/default.nix
        radiusRatio = 1.0;
      };
      
      location = {
        name = "Paris, France";
        weatherEnabled = true;
      };
      
      colorSchemes = {
        predefinedScheme = "Dracula";
        darkMode = true;
      };
    };
  };

  # Configure Niri window manager
  programs.niri = {
    settings = {
      # Spawn Noctalia is handled by systemd service
      # we don't need spawn-at-startup
      
      # Basic Niri configuration
      input = {
        keyboard.xkb = {
          layout = "fr";
        };
        
        touchpad = {
          tap = true;
          natural-scroll = true;
        };
      };

      layout = {
        gaps = 8;
        center-focused-column = "never";
      };

      # Keybindings for Noctalia
      binds = with config.lib.niri.actions; let
        # Utility function to call Noctalia IPC commands
        noctalia = cmd: [
          "noctalia-shell" "ipc" "call"
        ] ++ (pkgs.lib.splitString " " cmd);
      in {
        # Noctalia shortcuts (using different keys to avoid conflicts)
        "Mod+Space".action.spawn = noctalia "launcher toggle";
        "Mod+P".action.spawn = noctalia "sessionMenu toggle";
        "Mod+Escape".action.spawn = noctalia "lockScreen lock";  # Changed from Mod+L
        "Mod+N".action.spawn = noctalia "controlCenter toggle";
        
        # Volume controls
        "XF86AudioLowerVolume".action.spawn = noctalia "volume decrease";
        "XF86AudioRaiseVolume".action.spawn = noctalia "volume increase";
        "XF86AudioMute".action.spawn = noctalia "volume muteOutput";
        "XF86AudioMicMute".action.spawn = noctalia "volume muteInput";
        
        # Brightness controls
        "XF86MonBrightnessDown".action.spawn = noctalia "brightness decrease";
        "XF86MonBrightnessUp".action.spawn = noctalia "brightness increase";
        
        # Media controls
        "XF86AudioPlay".action.spawn = noctalia "media playPause";
        "XF86AudioNext".action.spawn = noctalia "media next";
        "XF86AudioPrev".action.spawn = noctalia "media previous";
        
        # Basic Niri window management
        "Mod+Q".action.close-window = {};
        "Mod+H".action.focus-column-left = {};
        "Mod+L".action.focus-column-right = {};
        "Mod+J".action.focus-window-down = {};
        "Mod+K".action.focus-window-up = {};
        
        "Mod+Shift+H".action.move-column-left = {};
        "Mod+Shift+L".action.move-column-right = {};
        "Mod+Shift+J".action.move-window-down = {};
        "Mod+Shift+K".action.move-window-up = {};
        
        # Workspaces
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        
        # Terminal
        "Mod+Return".action.spawn = ["alacritty"];
        
        # Screenshot
        "Print".action.spawn = ["grimblast" "copy" "area"];
      };

      # Window rules (examples)
      window-rules = [
        {
          matches = [{ app-id = "^org.gnome.Nautilus$"; }];
          default-column-width = { proportion = 0.5; };
        }
      ];
    };
  };

  # Configure Discord for Wayland
  xdg.configFile."discord/settings.json".text = builtins.toJSON {
    SKIP_HOST_UPDATE = true;
    chromiumSwitches = {
      "--enable-features" = "UseOzonePlatform,WaylandWindowDecorations";
      "--ozone-platform" = "wayland";
    };
  };

  # General Electron apps configuration for Wayland
  xdg.configFile."electron-flags.conf".text = ''
    --enable-features=UseOzonePlatform,WaylandWindowDecorations
    --ozone-platform=wayland
  '';
}