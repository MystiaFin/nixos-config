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
  ];

  home.sessionVariables = {
    TERMINAL = "kitty";
  };
}
