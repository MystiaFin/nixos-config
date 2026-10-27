{
  stateVersion,
  ...
}:

{
  imports = [
    ./zsh.nix
    ./niri.nix
    ./fontconfig.nix
    ./themes.nix
		./tmux.nix
		./nvim.nix
		./git.nix
		./emacs.nix
  ];

  home.stateVersion = stateVersion;
}
