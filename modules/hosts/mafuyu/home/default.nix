{ config, pkgs, inputs, ... }:

{
  imports = [
    ./niri.nix
    ./foot.nix
  ];

  home.packages = with pkgs; [
    foot
    inputs.helium-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
  ];

  home.sessionVariables = {
    TERMINAL = "foot";
  };
}
