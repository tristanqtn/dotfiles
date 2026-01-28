{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;

#    settings = { 
#      user = {
#        name  = "tristanqtn";
#        email = "tristan.querton@gmail.com";
#      };
#     init.defaultBranch = "main";
#      pull.rebase = true;
#    };

  };
}