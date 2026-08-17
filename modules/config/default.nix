{
  stateVersion,
  ...
}:

{
  imports = [
    ./fish.nix
    ./niri.nix
    ./fontconfig.nix
    ./themes.nix
		./tmux.nix
		./nvim.nix
		./git.nix
  ];

  home.stateVersion = stateVersion;
}
