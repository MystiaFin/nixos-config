{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    pcmanfm
    kdePackages.dolphin
		thunar
    yazi
    vesktop
    zed-editor
    vlc
    showmethekey
    onlyoffice-desktopeditors
    qalculate-gtk
    obs-studio
    inkscape-with-extensions
    localsend
    qbittorrent-enhanced
    aerc
    wineWow64Packages.stable
    winetricks
		kdePackages.gwenview
		kdePackages.ark
  ];
}
