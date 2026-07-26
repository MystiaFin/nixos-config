{ config, pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Asia/Jakarta";

  networking.networkmanager.enable = true;

  environment.variables = {
    XCURSOR_THEME = "catppuccin-mocha-dark-cursors";
    XCURSOR_SIZE = "14";
  };

  users.users.mystiafin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    git
    nano
    wget
    curl
    brightnessctl
    ripgrep
    ffmpeg
    vlc
    xwayland-satellite
    sddm-astronaut
    showmethekey
    tree
    inputs.zen-browser.packages."${pkgs.system}".default
    inputs.home-manager.packages.${pkgs.system}.home-manager
    opencode
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    extraPackages = with pkgs; [
      kdePackages.qtmultimedia
      kdePackages.qtsvg
      kdePackages.qt5compat
    ];
  };

  boot.plymouth = {
    enable = true;
    themePackages = with pkgs; [
      (catppuccin-plymouth.override { variant = "mocha"; })
    ];
  };

  programs.dconf.enable = true;

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  programs.fish.enable = true;

  programs.niri.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "overload(control, esc)";
          esc = "capslock";
        };
      };
    };
  };
}
