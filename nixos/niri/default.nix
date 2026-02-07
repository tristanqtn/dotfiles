{ pkgs, lib, config, ... }:

{
  ########################################
  # Niri
  ########################################
  programs.niri = {
    enable = true;
  };

  # Disable GNOME
  services.xserver.desktopManager.gnome.enable = lib.mkForce false;
  services.xserver.displayManager.gdm.enable = lib.mkForce false;

  # Enable GDM for Niri login
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri-session";
        user = "";
      };
    };
  };

  # XDG Portal configuration for Niri
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
  };

  # Required for screen sharing and other features
  services.dbus.enable = true;
  
  # Audio support
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Ensure XWayland is available
  programs.xwayland.enable = true;
}