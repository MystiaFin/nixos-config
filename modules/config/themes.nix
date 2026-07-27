{ config, pkgs, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    catppuccin-qt5ct
    catppuccin-cursors.mochaDark
    papirus-icon-theme
		kdePackages.qt6ct
    kdePackages.qtsvg
    (catppuccin-kde.override {
      flavour = [ "mocha" "macchiato" "frappe" "latte" ];
      accents = [ "blue" ];
    })
  ];

	xdg.configFile."kdeglobals".text = ''
    [Icons]
    Theme=Papirus-Dark
  '';

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
      adblock
    ];
  };

  gtk.enable = true;

  home.sessionVariables = {
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
    XCURSOR_THEME = "catppuccin-mocha-dark-cursors";
    XCURSOR_SIZE = "14";
  };
}
