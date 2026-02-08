{ config, lib, pkgs, hw_file, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [
      ./devices/${hw_file}.nix
      ./modules/nixvim.nix
      ./modules/boot.nix
      ./modules/desktop/nvidia.nix
      ./modules/desktop/games.nix
      ./modules/variables.nix
      ./modules/programs.nix
      ./modules/services.nix
      ./modules/users.nix
    ];

  powerManagement.cpuFreqGovernor = "performance";
  services.tlp = {
    enable = true;
    settings = {
      STOP_CHARGE_THRESH_BAT1 = 85;
      START_CHARGE_THRESH_BAT1 = 75;
    };
  };

  networking.hostName = hw_file;
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [ 53317 ];
  };
  systemd.services.NetworkManager-wait-online.enable = false;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  time.timeZone = "Asia/Jakarta";

  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id.indexOf("org.freedesktop.NetworkManager.") == 0 && subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs; [
      kdePackages.qtmultimedia
      kdePackages.qtsvg
      kdePackages.qt5compat
    ];
  };

  system.stateVersion = "25.11";
}
