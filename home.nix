{ config, pkgs, inputs, ... }:
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
  
  # General packages
  home.packages = with pkgs; [
    tmux
    kitty
    waybar
    wofi
    wlogout
    cloudflare-warp
    cloudflare-cli
    brightnessctl
    fastfetch
    nerd-fonts.jetbrains-mono
    vesktop
    quickshell
    qt6.qt5compat
    obs-studio
    xdg-desktop-portal-gnome
    google-fonts
    btop
    libnotify
		gtk3
		prismlauncher
		osu-lazer-bin
  ];
  
  home.sessionVariables = {
    QMLLS_BUILD_DIRS = "${pkgs.qt6.qtdeclarative}/lib/qt-6/qml:${pkgs.quickshell}/lib/qt-6/qml";
    QML_IMPORT_PATH = "${pkgs.qt6.qtdeclarative}/lib/qt-6/qml:${pkgs.quickshell}/lib/qt-6/qml:${pkgs.qt6.qt5compat}/lib/qt-6/qml";
  };
  
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    inputs.zen-browser.homeModules.beta
    ./home-manager/zsh.nix
    ./home-manager/kitty.nix
    ./home-manager/nvim.nix
    ./home-manager/waybar.nix
    ./home-manager/gtk.nix
    ./home-manager/tmux.nix
    ./home-manager/niri.nix
    ./home-manager/wofi.nix
    ./home-manager/wlogout.nix
  ];
  
  programs.bash.enable = true;
  programs.zen-browser.enable = true;
}
