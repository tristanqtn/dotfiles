{ pkgs, ... }:

{
  ########################################
  # Readline (vi mode + cursor shape)
  ########################################
  programs.readline = {
    enable = true;
    includeSystemConfig = true;
    variables = {
      editing-mode = "vi";
      show-mode-in-prompt = true;
      vi-ins-mode-string = ''\1\e[6 q\2''; # bar cursor
      vi-cmd-mode-string = ''\1\e[2 q\2''; # block cursor
    };
  };

  ########################################
  # Bash
  ########################################
  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      # eza
      ls   = "${pkgs.eza}/bin/eza --group-directories-first";
      l    = "${pkgs.eza}/bin/eza -lah --git";
      ll   = "${pkgs.eza}/bin/eza -lh --git";
      tree = "${pkgs.eza}/bin/eza -T --git-ignore";

      # git
      gs = "git status";
      gl = "git log --oneline --graph --decorate --color=always";
      gd = "git diff";
      ga = "git add .";

      # nix
      rebuild = "sudo nixos-rebuild switch";
      update  = "sudo nixos-rebuild switch --upgrade";
      switch = "nh os switch .";

      # misc
      v  = "nvim";
      co = "code .";
      ex = "xdg-open .";

    };

    initExtra = ''
      ####################################
      # History
      ####################################
      HISTSIZE=10000
      HISTFILESIZE=20000
      HISTCONTROL=ignoreboth
      shopt -s histappend
      shopt -s cmdhist

      ####################################
      # Environment
      ####################################
      export EDITOR=nvim
      export VISUAL=nvim
      export PAGER=less
      export LESS=-R
      export COLORTERM=truecolor

      ####################################
      # fzf – Dracula + reverse layout
      ####################################
      export FZF_DEFAULT_OPTS="
        --height=40%
        --layout=reverse
        --border
        --prompt='❯ '
        --pointer='▶'
        --marker='✓'
        --color=bg+:#44475a,bg:#282a36
        --color=fg:#f8f8f2,fg+:#ffffff
        --color=hl:#ff79c6,hl+:#ff79c6
        --color=info:#bd93f9,prompt:#bd93f9
        --color=pointer:#ff79c6,marker:#50fa7b,spinner:#f8f8f2
        --color=header:#6272a4
      "

      export FZF_CTRL_R_OPTS="
        --sort
        --exact
        --preview 'echo {}'
      "

      ####################################
      # eza / ls colors (Dracula-friendly)
      ####################################
      export LS_COLORS="
        di=38;5;81:
        fi=38;5;253:
        ln=38;5;212:
        ex=38;5;118:
        bd=38;5;215:
        cd=38;5;215:
        so=38;5;214:
        pi=38;5;214:
      "
    '';
  };
}
