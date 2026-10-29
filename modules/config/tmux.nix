{
  config,
  pkgs,
  ...
}:

{
  programs.tmux = {
    enable = true;

    plugins = with pkgs.tmuxPlugins; [
      resurrect
      continuum
    ];

    extraConfig = ''
      set -g @continuum-restore 'on'

      # windows and panes start at 1
      set -g base-index 1
      set -g pane-base-index 1
      set -g renumber-windows on

      # vi key bindings
      set -g mode-keys vi
      set -g status-keys vi
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5
      bind "|" split-window -h
      bind "-" split-window -v

      # switch windows with Alt+Shift+number
      bind -n M-! select-window -t :1
      bind -n M-@ select-window -t :2
      bind -n M-# select-window -t :3
      bind -n M-$ select-window -t :4
      bind -n M-% select-window -t :5
      bind -n M-^ select-window -t :6
      bind -n M-& select-window -t :7
      bind -n M-* select-window -t :8
      bind -n M-( select-window -t :9
      bind -n M-) select-window -t :10

      # drop the prefix+number window switching
      unbind-key -T prefix 1
      unbind-key -T prefix 2
      unbind-key -T prefix 3
      unbind-key -T prefix 4
      unbind-key -T prefix 5
      unbind-key -T prefix 6
      unbind-key -T prefix 7
      unbind-key -T prefix 8
      unbind-key -T prefix 9
      unbind-key -T prefix 0

      # --- status bar ---
      # colors and segments come from amane (~/.local/state/amane/tmux-colors.conf),
      # so they follow the shell theme; only the layout lives here
      set -g status-interval 1
      set -g status-justify left
      set -g status-left-length 80
      set -g status-right-length 80
    '';
  };
}
