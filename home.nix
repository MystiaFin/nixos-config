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
    fastfetch 
    nerd-fonts.jetbrains-mono
		discord-ptb
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Catppuccin-Mocha-Dark-Cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 14;
  };
  home.sessionVariables = {
    XCURSOR_THEME = "Catppuccin-Mocha-Dark-Cursors";
    XCURSOR_SIZE = "14";
    XCURSOR_PATH = "${config.home.homeDirectory}/.icons:${config.home.homeDirectory}/.nix-profile/share/icons:/usr/share/icons";
  };

  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    inputs.zen-browser.homeModules.beta
    ./home-manager/zsh.nix
    ./home-manager/kitty.nix
    ./home-manager/nvim.nix
    ./home-manager/hyprland.nix
    ./home-manager/waybar.nix
    ./home-manager/gtk.nix
  ];


  programs.bash.enable = true;
  programs.zen-browser.enable = true;
}
