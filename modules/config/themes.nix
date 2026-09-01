{
  config,
  pkgs,
  inputs,
  ...
}:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  catppuccinGtk = pkgs.catppuccin-gtk.override { variant = "mocha"; };
  catppuccinGtkTheme = "${catppuccinGtk}/share/themes/catppuccin-mocha-blue-standard/gtk-3.0";
  dynamicGtkCss = ''
    @import url("file:///home/mystiafin/.config/quickshell/gtk-dynamic.css");
  '';
  dynamicGtkIndex = ''
    [Desktop Entry]
    Type=X-GNOME-Metatheme
    Name=Quickshell Dynamic
    Comment=Wallpaper-derived Quickshell GTK theme
    Encoding=UTF-8

    [X-GNOME-Metatheme]
    GtkTheme=QuickshellDynamicA
    IconTheme=Papirus-Dark
    CursorTheme=catppuccin-mocha-dark-cursors
  '';
  switchGtkTheme = pkgs.writeShellScriptBin "quickshell-gtk-theme" ''
    case "$1" in
      QuickshellDynamicA|QuickshellDynamicB) ;;
      *) exit 2 ;;
    esac

    export GSETTINGS_SCHEMA_DIR="${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas"
    exec ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme "$1"
  '';
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    catppuccin-qt5ct
    catppuccin-cursors.mochaDark
    papirus-icon-theme
    switchGtkTheme
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
  xdg.configFile."quickshell/gtk-base.css".source = "${catppuccinGtkTheme}/gtk.css";
  xdg.configFile."quickshell/gtk-assets".source = "${catppuccinGtkTheme}/assets";

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
      name = "QuickshellDynamicA";
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  home.file = {
    ".local/share/themes/QuickshellDynamicA/index.theme".text = dynamicGtkIndex;
    ".local/share/themes/QuickshellDynamicA/gtk-3.0/gtk.css".text = dynamicGtkCss;
    ".local/share/themes/QuickshellDynamicB/index.theme".text = dynamicGtkIndex;
    ".local/share/themes/QuickshellDynamicB/gtk-3.0/gtk.css".text = dynamicGtkCss;
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
