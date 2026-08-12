{ pkgs, isDesktop, lib, ... }:

let
  stirlingPdfImage = "docker.stirlingpdf.com/stirlingtools/stirling-pdf:1.7.4";
  stirlingPdfDataDir = "$HOME/.local/share/stirling-pdf";

  stirling-pdf-launcher = pkgs.writeShellScriptBin "stirling-pdf-launcher" ''
    set -euo pipefail

    mkdir -p "${stirlingPdfDataDir}"/{configs,logs,customFiles,trainingData}

    if ! docker start stirling-pdf 2>/dev/null; then
      docker run -d \
        --name stirling-pdf \
        --restart unless-stopped \
        -p 8080:8080 \
        -v "${stirlingPdfDataDir}/configs:/configs" \
        -v "${stirlingPdfDataDir}/logs:/logs" \
        -v "${stirlingPdfDataDir}/customFiles:/customFiles" \
        -v "${stirlingPdfDataDir}/trainingData:/usr/share/tessdata" \
        ${stirlingPdfImage}
    fi

    echo "Waiting for Stirling PDF to become ready..."
    for _ in $(seq 1 30); do
      if ${pkgs.curl}/bin/curl -sf http://localhost:8080/api/v1/info/status >/dev/null 2>&1; then
        break
      fi
      sleep 1
    done

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
