{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    kdePackages.dolphin
    yazi
    vesktop
    ungoogled-chromium
    zed-editor
    vlc
    showmethekey
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
    onlyoffice-desktopeditors
    qalculate-gtk
    obs-studio
    inkscape-with-extensions
    localsend
    qbittorrent-enhanced
    aerc
    wineWow64Packages.stable
    winetricks
  ];
}
