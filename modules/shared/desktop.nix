{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    sddm-astronaut
    xwayland-satellite
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

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };
}
