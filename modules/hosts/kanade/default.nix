{
  config,
  pkgs,
  inputs,
  stateVersion,
  ...
}:

let
  # allowUnfree so the kernel's nvidia module can come from unstable too
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
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

  # newest mt76 fixes; 6.18 panicked in mt76_dma_add_buf after the chip hung
  boot.kernelPackages = unstable.linuxPackages_latest;

  networking.networkmanager.wifi.powersave = false;

  boot.extraModprobeConfig = ''
    options mt7921e disable_aspm=1
  '';

  # mt7921 firmware hangs ("driver own failed") when woken from its own low-power states
  systemd.services.mt7921-disable-pm = {
    wantedBy = [ "sys-subsystem-net-devices-wlp3s0.device" ];
    after = [ "sys-subsystem-net-devices-wlp3s0.device" "sys-kernel-debug.mount" ];
    serviceConfig.Type = "oneshot";
    script = ''
      for p in /sys/kernel/debug/ieee80211/phy*/mt76; do
        echo 0 > $p/runtime-pm
        echo 0 > $p/deep-sleep
      done
    '';
  };

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
