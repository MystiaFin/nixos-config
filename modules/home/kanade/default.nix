{ config, pkgs, ... }:

{
  imports = [
    ./kitty.nix
    ./niri.nix
  ];

  home.packages = with pkgs; [
    kitty
    prismlauncher
    osu-lazer-bin
    kdePackages.kdenlive
  ];

  home.sessionVariables = {
    TERMINAL = "kitty";
  };
}
