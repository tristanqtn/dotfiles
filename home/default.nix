{
  username,
  firefox-addons,
  pkgs,
  nvf,
  ...
}:

let
  myCustomPkgs = import ../pkgs { inherit pkgs; };
in
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home-manager.users.${username} =
    { pkgs, ... }:
    {
      ########################################
      # Home config
      ########################################
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "26.05";

      ########################################
      # Imports
      ########################################
      imports = [
        # Looking
        ./avatar

        # Browser
        ./firefox

        # Dev
        ./git
        ./vscode

        # Terminal
        ./nh
        ./bat
        ./nvf
        ./fzf
        ./bash
        ./tmux
        ./zoxide
        ./starship
        ./ripgrep
        ./alacritty
        nvf.homeManagerModules.default

        # Deactivated
        #./noctalia
      ];

      ########################################
      # Home Packages
      ########################################
      home.packages =
        (with pkgs; [
          # Python
          python314
          python314Packages.pip
          python314Packages.pipx

          # File manager
          gnome-text-editor
          nautilus

          # Others
          eza
          openvpn
          fd
          xclip
          vivid
          discord
          obsidian
          nodejs_25
          _1password-gui

          # Noctalia Shell Required Packages
          # Screenshot tools
          #grim
          #slurp
          #grimblast
          # Clipboard
          #wl-clipboard
          # Other utilities
          #pavucontrol
          #networkmanagerapplet
        ])
        ++ (with myCustomPkgs; [
          exegol
        ]);
    };
}
