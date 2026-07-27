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

  users.users.mystiafin = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.fish;
  };
}
