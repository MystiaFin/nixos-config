{ config, pkgs, inputs, ... }:

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
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
    ungoogled-chromium
    teams-for-linux
  ];

  home.sessionVariables = {
    TERMINAL = "kitty";
  };
}
