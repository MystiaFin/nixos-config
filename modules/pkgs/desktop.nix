{ pkgs, isDesktop, lib, ... }:

let
  stirling-pdf-launcher = pkgs.writeShellScriptBin "stirling-pdf-launcher" ''
    docker start stirling-pdf
    sleep 5
    ${pkgs.stirling-pdf-desktop}/bin/stirling-pdf
    docker stop stirling-pdf
  '';
in
lib.mkIf isDesktop {
  home.packages = with pkgs; [
    quickshell
    wlogout
    qt6.qt5compat
    qt6.qtsvg
    qt6Packages.qt6ct
    xdg-desktop-portal-gtk
    kdePackages.ark
    kdePackages.kservice
    cava
    nwg-look
    stirling-pdf-desktop
  ];

  xdg.desktopEntries."stirling-pdf" = {
    name = "Stirling PDF";
    comment = "Locally hosted web PDF manipulation tool";
    exec = "${stirling-pdf-launcher}/bin/stirling-pdf-launcher";
    categories = [ "Office" ];
  };
}
