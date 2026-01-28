{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    terminal = "screen-256color";
    keyMode = "vi";

    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-save-bash-history 'on'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on' 
          set -g @continuum-save-interval '15'
        '';
      }
    ];

    extraConfig = ''
      set -ga terminal-overrides ',*:Tc'

      set -g base-index 1
      setw -g pane-base-index 1

      bind -n M-! select-window -t 1
      bind -n M-@ select-window -t 2
      bind -n M-# select-window -t 3
      bind -n M-$ select-window -t 4
      bind -n M-% select-window -t 5

      bind -n M-h previous-window
      bind -n M-l next-window

      set -g status on
      set -g status-interval 2
      set -g status-style ""

      set -g status-left "#[fg=#24273a,bg=#f9e2af]  #[fg=#f9e2af,bg=#24273a]"
      set -g status-left-length 60

      set -g window-status-separator ""

      set -g window-status-format "#[fg=#24273a,bg=#45475a]#[fg=#cdd6f4,bg=#45475a] #W #[fg=#45475a,bg=#24273a]"

      set -g window-status-current-format "#[fg=#24273a,bg=#89b4fa]#[fg=#11111b,bg=#89b4fa,bold] #W #[fg=#89b4fa,bg=#24273a]"
      set -g window-status-current-style "fg=#11111b,bg=#89b4fa,bold"

      set -g status-right "#S #[fg=#45475a,bg=#24273a]#[fg=#cdd6f4,bg=#45475a] #H #[fg=#f9e2af,bg=#45475a]#[fg=#11111b,bg=#f9e2af] %H:%M:%S "
      set -g status-right-length 50

      set -g pane-border-style "fg=#45475a"
      set -g pane-active-border-style "fg=#89b4fa"

      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
    '';
  };
}
