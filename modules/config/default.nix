{
  stateVersion,
  ...
}:

{
  imports = [
    ./fish.nix
    ./niri.nix
    ./quickshell.nix
    ./fontconfig.nix
    ./themes.nix
		./tmux.nix
		./nvim.nix
		./git.nix
  ];

  home.stateVersion = stateVersion;
}
