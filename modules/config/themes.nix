{
  config,
  pkgs,
  inputs,
  ...
}:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
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
      flavour = [
        "mocha"
        "macchiato"
        "frappe"
        "latte"
      ];
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

  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-blue-standard";
      package = pkgs.catppuccin-gtk.override { variant = "mocha"; };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
	xdg.configFile."gtk-4.0/settings.ini".enable = false;

  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "catppuccin-mocha-dark-cursors";
    size = 14;
    gtk.enable = true;
  };

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
  };
}
