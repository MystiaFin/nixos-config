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
		./bottom.nix
  ];

  home.stateVersion = stateVersion;
}
