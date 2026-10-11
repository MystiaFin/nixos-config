{
  config,
  pkgs,
  inputs,
  stateVersion,
  ...
}:

let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    ./hardware-configuration.nix
    ../../configurations/desktop.nix
    ./mouse-debounce.nix
  ];

  networking.hostName = "kanade";

  features.desktop = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt
    protonplus
    opentabletdriver
  ];

  networking.networkmanager.wifi.powersave = false;

  boot.extraModprobeConfig = ''
    options mt7921e disable_aspm=1
  '';

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  # hyprland 0.56 from unstable, to test amane against it (amane issue #7)
  programs.hyprland = {
    enable = true;
    package = unstable.hyprland;
    portalPackage = unstable.xdg-desktop-portal-hyprland;
  };

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
