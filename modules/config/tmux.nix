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

      # --- Nord powerline status bar ---
      # Layout copied from nord-tmux, but with explicit Nord hex colors so it
      # looks Nord regardless of the terminal's ANSI palette
      set -g status-interval 1
      set -g status-justify left
      set -g status-style bg=#2e3440,fg=#d8dee9
      set -g status-left-length 80

      # nord0 #2e3440  nord3 #4c566a  nord6 #eceff4
      # nord8 #88c0d0  nord10 #5e81ac
      set -g status-left "#[fg=#2e3440,bg=#5e81ac,bold] #S #[fg=#5e81ac,bg=#2e3440,nobold,noitalics,nounderscore]"
      set -g status-right "#[fg=#4c566a,bg=#2e3440,nobold,noitalics,nounderscore]#[fg=#eceff4,bg=#4c566a] %Y-%m-%d #[fg=#eceff4,bg=#4c566a,nobold,noitalics,nounderscore]#[fg=#eceff4,bg=#4c566a] %H:%M #[fg=#88c0d0,bg=#4c566a,nobold,noitalics,nounderscore]#[fg=#2e3440,bg=#88c0d0,bold] #H "

      set -g window-status-format "#[fg=#2e3440,bg=#4c566a,nobold,noitalics,nounderscore] #[fg=#eceff4,bg=#4c566a]#I #[fg=#eceff4,bg=#4c566a,nobold,noitalics,nounderscore] #[fg=#eceff4,bg=#4c566a]#W #F #[fg=#4c566a,bg=#2e3440,nobold,noitalics,nounderscore]"
      set -g window-status-current-format "#[fg=#2e3440,bg=#88c0d0,nobold,noitalics,nounderscore] #[fg=#2e3440,bg=#88c0d0]#I #[fg=#2e3440,bg=#88c0d0,nobold,noitalics,nounderscore] #[fg=#2e3440,bg=#88c0d0]#W #F #[fg=#88c0d0,bg=#2e3440,nobold,noitalics,nounderscore]"
      set -g window-status-separator ""
    '';
  };
}
