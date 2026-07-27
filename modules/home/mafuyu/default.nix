{ config, pkgs, ... }:

{
  imports = [
    ./niri.nix
    ./foot.nix
  ];

  home.packages = with pkgs; [
    foot
  ];

  home.sessionVariables = {
    TERMINAL = "foot";
  };
}
