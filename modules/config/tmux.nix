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
    '';
  };
}
