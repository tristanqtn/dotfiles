{ config, pkgs, ... }:

{
    programs.tmux = {
    enable = true;

    # Extra config in tmux syntax
    extraConfig = ''
        # List of plugins (managed by TPM)
        set -g @plugin 'tmux-plugins/tpm'
        set -g @plugin 'tmux-plugins/tmux-sensible'
        set -g @plugin 'tmux-plugins/tmux-logging'

        # Initialize TMUX plugin manager (keep at bottom)
        run '~/.tmux/plugins/tpm/tpm'

        # Scrollback & colors
        set -g default-terminal 'tmux-256color'
        set -ga terminal-overrides ',xterm-256color:Tc'
        set -g history-limit 10000

        # Mouse + Vi
        set -g mouse on
        set -g mode-keys vi

        # Clipboard
        set-option -s set-clipboard off
        bind P paste-buffer
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi y send-keys -X rectangle-toggle
        unbind -T copy-mode-vi Enter
        bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel 'xclip -se c -i'
        bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel 'xclip -se c -i'
    '';
    };
}
