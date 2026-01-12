{ config, lib, pkgs, hw_file, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [
      ./devices/${hw_file}.nix
			./modules/nixvim.nix
    ];

  boot = {
    loader.systemd-boot = {
      enable = true;
      consoleMode = "max";
    };
    loader.efi.canTouchEfiVariables = true;
    consoleLogLevel = 0;
    initrd.verbose = false;
    plymouth = {
      enable = true;
      theme = "catppuccin-mocha";
      themePackages = with pkgs; [
        (catppuccin-plymouth.override { variant = "mocha"; })
      ];
    };

    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "vt.global_cursor_default=0"
      "fbcon=nodefer"
    ] ++ lib.optionals (hw_file == "nixos") [
      "pcie_aspm=off"
      "mt7921e.disable_aspm=1"
      "amdgpu.dcdebugmask=0x10"
    ];
  };

  hardware.nvidia = lib.mkIf (hw_file == "nixos") {
    modesetting.enable = true;
    open = true;
    powerManagement.enable = true;
  };

  hardware.graphics = lib.mkIf (hw_file == "nixos") {
    enable = true;
    enable32Bit = true;
  };

  programs.steam = lib.mkIf (hw_file == "nixos") {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;

    extraPackages = with pkgs; [
      catppuccin-cursors.mochaDark
    ];
  };

  programs.gamemode.enable = lib.mkIf (hw_file == "nixos") true;
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
  systemd.services.NetworkManager-wait-online.enable = false;

  time.timeZone = "Asia/Jakarta";

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.variables = {
    XCURSOR_THEME = "catppuccin-mocha-dark-cursors";
    XCURSOR_SIZE = "14";
    GTK_THEME = "catppuccin-mocha-blue-standard";
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    xwayland-satellite
    catppuccin-cursors.mochaDark
    sddm-astronaut
  ] ++ lib.optionals (hw_file == "nixos") [
    opentabletdriver
    mangohud
    protonup-qt
  ];

  programs.niri.enable = true;
	programs.sway.enable = true;
  programs.zsh.enable = true;
  programs.mtr.enable = true;

  services.xserver.wacom.enable = lib.mkIf (hw_file == "nixos") true;
  hardware.opentabletdriver.enable = lib.mkIf (hw_file == "nixos") true;

  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id.indexOf("org.freedesktop.NetworkManager.") == 0 && subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.dconf.enable = true;

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  users.users.mystiafin = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "libvirtd" "docker" ];
    packages = with pkgs; [
      tree
    ];
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(control, esc)";
            esc = "capslock";
          };
        };
      };
    };
  };

  services.libinput.enable = true;
  services.xserver.videoDrivers = lib.mkIf (hw_file == "nixos") [ "nvidia" ];
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
  services.printing.enable = true;
  services.openssh.enable = true;
  services.cloudflare-warp.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  system.stateVersion = "25.05";
}
