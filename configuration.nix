{ config, lib, pkgs, hw_file, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [
      ./devices/${hw_file}.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = hw_file;
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Jakarta";

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.variables = {
    XCURSOR_THEME = "catppuccin-mocha-dark-cursors";
    XCURSOR_SIZE = "14";
    GTK_THEME = "catppuccin-mocha-blue-standard";
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    xwayland-satellite
    catppuccin-cursors.mochaDark
  ];

  programs.niri.enable = true;
  programs.zsh.enable = true;
  programs.mtr.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.dconf.enable = true;

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
  services.displayManager.ly.enable = true;
  services.printing.enable = true;
  services.openssh.enable = true;
  services.cloudflare-warp.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  system.stateVersion = "25.05";
}
