{ config, pkgs, inputs, ... }:

{
  imports = [
    ./desktop.nix
    ./tools.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  time.timeZone = "Asia/Jakarta";

  networking.networkmanager.enable = true;

  environment.variables = {
    XCURSOR_THEME = "catppuccin-mocha-dark-cursors";
    XCURSOR_SIZE = "14";
  };

  users.users.mystiafin = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.fish;
  };
}
