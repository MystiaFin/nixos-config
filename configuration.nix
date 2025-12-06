{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [
    ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Jakarta";

  environment.systemPackages = with pkgs; [
    neovim
      wget
      kitty
      waybar
      git
      cloudflare-warp
      cloudflare-cli
      brightnessctl
      xfce.thunar-volman
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.zsh.enable = true;
  programs.mtr.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.dconf.enable = true;

  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
      thunar-volman
  ];

	programs.tmux = {
					enable=true;
					clock24 = true;
					extraConfig = ''
									'';
	};

  users.users.mystiafin = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "libvirtd" ];
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
  };

  services.libinput.enable = true;
  services.displayManager.ly.enable = true;
  services.printing.enable = true;
  services.openssh.enable = true;
  services.cloudflare-warp.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  system.stateVersion = "25.05";

}

