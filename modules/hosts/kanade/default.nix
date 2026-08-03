{ config, pkgs, stateVersion, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../configurations/desktop.nix
  ];

  networking.hostName = "kanade";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt
    opentabletdriver
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    powerManagement.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  system.stateVersion = stateVersion;
}
