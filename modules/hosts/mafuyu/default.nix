{ config, pkgs, stateVersion, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../configurations/desktop.nix
  ];

  networking.hostName = "mafuyu";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = stateVersion;
}
