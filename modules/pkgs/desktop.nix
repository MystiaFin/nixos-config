{ pkgs, ... }: {
  home.packages = with pkgs; [
    quickshell
    wlogout
    qt6.qt5compat
    qt6.qtsvg
    qt6Packages.qt6ct
    xdg-desktop-portal-gtk
  ];
}
