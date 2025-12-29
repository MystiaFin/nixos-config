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
    ./home-manager/zsh.nix
    ./home-manager/nvim.nix
    ./home-manager/gtk.nix
    ./home-manager/tmux.nix
    ./home-manager/niri.nix
    ./home-manager/wofi.nix
    ./home-manager/wlogout.nix
		./home-manager/btop.nix
  ] ++ (if device == "low-end" then [
    ./home-manager/foot.nix
  ] else [
    ./home-manager/kitty.nix
  ]);

  home.packages = with pkgs; [
    tmux
    wofi
    wlogout
    cloudflare-warp
    cloudflare-cli
    brightnessctl
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
		nautilus
		bluez-tools
		fuzzel
		microfetch
  ] ++ (if device == "low-end" then [
    foot
  ] else [
    kitty
    prismlauncher
    osu-lazer-bin
  ]);
  
  home.sessionVariables = {
    QMLLS_BUILD_DIRS = "${pkgs.qt6.qtdeclarative}/lib/qt-6/qml:${pkgs.quickshell}/lib/qt-6/qml";
    QML_IMPORT_PATH = "${pkgs.qt6.qtdeclarative}/lib/qt-6/qml:${pkgs.quickshell}/lib/qt-6/qml:${pkgs.qt6.qt5compat}/lib/qt-6/qml";
  };
  
  programs.bash.enable = true;
  programs.zen-browser.enable = true;
}
