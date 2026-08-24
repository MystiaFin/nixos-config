{ config, pkgs, inputs, ... }:

let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "pixel_sakura";
  };
in
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      material-design-icons
      roboto
      open-sans
      poppins
      raleway
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      corefonts
      inter
    ];
  };

  environment.systemPackages = [
    sddm-astronaut
		pkgs.easyeffects
    pkgs.xwayland-satellite
    pkgs.simple-scan
    pkgs.file-roller
  ];

  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "sddm-astronaut-theme";
    wayland.enable = true;
    extraPackages = [
      sddm-astronaut
      pkgs.kdePackages.qtmultimedia
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qt5compat
    ];
  };

  boot.plymouth = {
    enable = true;
  };

  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "splash"
    "rd.udev.log_level=3"
    "rd.systemd.show_status=false"
  ];

  programs.dconf.enable = true;

  services.udisks2.enable = true;

  security.polkit.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
      thunar-media-tags-plugin
    ];
  };

  programs.xfconf.enable = true;

  services.gvfs.enable = true;
  services.tumbler.enable = true;

  services.printing.enable = true;

  services.ipp-usb.enable = true;
	services.printing.drivers = [ pkgs.cnijfilter2 ];

	hardware.sane.enable = true;
	hardware.sane.extraBackends = [ pkgs.sane-airscan ];
	services.saned.enable = true;

	services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

	environment.sessionVariables = {
    XDG_MENU_PREFIX = "plasma-";
  };

	environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
}
