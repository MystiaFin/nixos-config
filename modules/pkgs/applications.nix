{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    pcmanfm
    kdePackages.dolphin
		thunar
    yazi
    inputs.zennotes.packages.${pkgs.system}.zennotes-desktop
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
    rofi
    wineWow64Packages.stable
    winetricks
		kdePackages.gwenview
		zathura
		zathuraPkgs.zathuraWrapper
  ];
}
