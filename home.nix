{ config, pkgs, inputs, device, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
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

  home.username = "mystiafin";
  home.homeDirectory = "/home/mystiafin";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    inputs.zen-browser.homeModules.beta
    ./home-manager/fish.nix
    ./home-manager/gtk.nix
    ./home-manager/tmux.nix
    ./home-manager/wofi.nix
    ./home-manager/wlogout.nix
    ./home-manager/btop.nix
    ./home-manager/niri.nix
    ./home-manager/bash.nix
		./home-manager/cava.nix
  ] ++ (if device == "thinkpad" then [
    ./home-manager/foot.nix
  ] else [
    ./home-manager/kitty.nix
  ]);

  home.packages = with pkgs; [
    tmux
    wlogout
    cloudflare-warp
    cloudflare-cli
    brightnessctl
    nerd-fonts.jetbrains-mono
    quickshell
    qt6.qt5compat
    obs-studio
    xdg-desktop-portal-gtk
    google-fonts
    inter
    btop
    libnotify
    gtk3
    nemo
    bluez-tools
    microfetch
    qbittorrent-enhanced
    playerctl
    cava
    cmatrix
    qt6.qtsvg
    inkscape-with-extensions
    ffmpeg
    unzip
    vesktop
    ungoogled-chromium
    unrar
    vlc
    p7zip
    localsend
    yazi
    lsd
    wineWowPackages.stable
    winetricks
		zed-editor
  ] ++ (if device == "thinkpad" then [
    foot
  ] else [
    kitty
    prismlauncher
    osu-lazer-bin
  ]);

  home.sessionVariables = {
    QMLLS_BUILD_DIRS = "${pkgs.qt6.qtdeclarative}/lib/qt-6/qml:${pkgs.quickshell}/lib/qt-6/qml";
    QML_IMPORT_PATH = "${pkgs.qt6.qtdeclarative}/lib/qt-6/qml:${pkgs.quickshell}/lib/qt-6/qml:${pkgs.qt6.qt5compat}/lib/qt-6/qml";
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
  };
  xdg.configFile."fontconfig/fonts.conf".text = ''
    <?xml version='1.0'?>
    <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
    <fontconfig>
     <match target="font">
      <edit mode="assign" name="hinting">
       <bool>false</bool>
      </edit>
     </match>
     
     <match target="font">
      <edit mode="assign" name="hintstyle">
       <const>hintslight</const>
      </edit>
     </match>

     <match target="font">
      <edit mode="assign" name="rgba">
       <const>rgb</const>
      </edit>
     </match>
     <match target="font">
      <edit mode="assign" name="antialias">
       <bool>true</bool>
      </edit>
     </match>
     <match target="font">
      <edit mode="assign" name="lcdfilter">
       <const>lcddefault</const>
      </edit>
     </match>
    </fontconfig>
  '';

  programs.bash.enable = true;
  programs.zen-browser.enable = true;
}
