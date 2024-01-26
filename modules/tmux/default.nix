{ pkgs, ... }: {
    programs.tmux = {
        enable = true;
        keyMode = "vi";
        historyLimit = 50000;
        mouse = true;
        escapeTime = 10;
        terminal = "screen-256color";
        baseIndex = 1;
        extraConfig = ''
        set-option -g renumber-window on
        setw -g mode-keys vi

        # set -g prefix C-s
        # bind C-s send-prefix

        bind-key o kill-pane
        bind-key u previous-window
        bind-key i next-window

        # open splits and windows in the current folder
        bind n split-window -p 30 -c "#{pane_current_path}"
        bind m split-window -p 50 -h -c "#{pane_current_path}"
        bind . new-window -c "#{pane_current_path}"


        # vim-like pane switching
        bind k select-pane -U
        bind j select-pane -D
        bind h select-pane -L
        bind l select-pane -R

        # resize pane shortcuts
        bind -r H resize-pane -L 10
        bind -r J resize-pane -D 10
        bind -r K resize-pane -U 10
        bind -r L resize-pane -R 10

        # don't dettach session when closing the last pane
        set -g detach-on-destroy off

        # theme
        set-option -g status-left-length 100
        set-option -g status-left " #{session_name}  "
        set-option -g status-style "fg=#7C7D83 bg=default" # default will set the background to transparent
        set-option -g window-status-format "#{window_index}:#{window_name}#{window_flags} " # window_name -> pane_current_command
        set-option -g window-status-current-format "#{window_index}:#{window_name}#{window_flags} "
        set-option -g window-status-current-style "fg=#dcc7a0"
        set-option -g window-status-activity-style none
        '';
    };

}
