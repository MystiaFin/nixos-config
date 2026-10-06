{
  config,
  pkgs,
  inputs,
  isDesktop,
  lib,
  ...
}:

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

  # amane links these, both when the cli is built and when it builds a shell
  amaneLibraries = with pkgs; [
    fontconfig
    freetype
    expat
    wayland
    libxkbcommon
    vulkan-loader
    libpulseaudio
    linux-pam
  ];

  # what `cargo install --path cli` and `amane dev` need to find those libraries;
  # pam is linked by name rather than found through pkg-config, so it needs a search path
  amaneEnv = {
    PKG_CONFIG_PATH = lib.makeSearchPathOutput "dev" "lib/pkgconfig" amaneLibraries;
    LIBRARY_PATH = lib.makeLibraryPath [ pkgs.linux-pam ];
    LD_LIBRARY_PATH = lib.makeLibraryPath (with pkgs; [ vulkan-loader wayland ]);
  };

  # niri spawns amane without a login shell's variables or ~/.cargo/bin on PATH,
  # so this gives the cargo-installed cli the same environment
  amane = pkgs.writeShellScriptBin "amane" ''
    export PATH=${lib.makeBinPath (with pkgs; [ cargo rustc pkg-config stdenv.cc ])}''${PATH:+:$PATH}
    export PKG_CONFIG_PATH=${amaneEnv.PKG_CONFIG_PATH}''${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}
    export LIBRARY_PATH=${amaneEnv.LIBRARY_PATH}''${LIBRARY_PATH:+:$LIBRARY_PATH}
    export LD_LIBRARY_PATH=${amaneEnv.LD_LIBRARY_PATH}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}

    exec "$HOME/.cargo/bin/amane" "$@"
  '';
in
lib.mkIf isDesktop {
  # lets a plain `cargo install --path cli` build amane in any shell
  home.sessionVariables = amaneEnv;

  home.packages = with pkgs; [
    amane
    quickshell
    imagemagick
    wlogout
    qt6.qt5compat
    qt6.qtsvg
    qt6Packages.qt6ct
    xdg-desktop-portal-gtk
    kdePackages.ark
    kdePackages.kservice
    cava
    nwg-look
    wdisplays
    wl-mirror
		qt6.qtshadertools
  ];

  xdg.desktopEntries."stirling-pdf" = {
    name = "Stirling PDF";
    comment = "Locally hosted web PDF manipulation tool";
    exec = "${stirling-pdf-launcher}/bin/stirling-pdf-launcher";
    categories = [ "Office" ];
  };

  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=${config.home.sessionVariables.TERMINAL}
  '';
}
