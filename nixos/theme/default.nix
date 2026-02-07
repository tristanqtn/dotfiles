{ pkgs, lib, ... }:

{
  ########################################
  # Stylix
  ########################################
  stylix = {
    enable = lib.mkForce true;
    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    image = ./wallpaper/nixos.png;

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 15;
        desktop = 15;
        popups = 15;
        terminal = 15;
      };
    };
  };
}
