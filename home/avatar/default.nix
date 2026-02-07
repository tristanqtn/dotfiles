{
  config,
  pkgs,
  lib,
  ...
}:

let
  username = config.home.username;
  avatarFile = ./avatar.jpg;
in
{
  ########################################
  # Profile Picture
  ########################################
  # Copy avatar to ~/.face.png
  home.file.".face.png".source = avatarFile;

  # GNOME / GDM login manager (AccountsService)
  home.file.".config/accountsservice/users/${username}" = {
    text = lib.concatStringsSep "\n" [
      "[User]"
      "Icon=/home/${username}/.face.png"
    ];
  };

  home.file.".face".source = avatarFile;
}
