{ pkgs, ... }:

{
  ########################################
  # Git
  ########################################
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    
    settings = { 
      user = {
        name  = "tristanqtn";
        email = "tristan.querton@gmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;

      commit.gpgsign = true;

      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_ed25519";
    };
  };
}
