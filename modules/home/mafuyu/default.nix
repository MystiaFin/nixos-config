{ config, pkgs, ... }:

{
  imports = [
    ./niri.nix
  ];

  home.packages = with pkgs; [
    foot
  ];

  home.sessionVariables = {
    TERMINAL = "foot";
  };
}
