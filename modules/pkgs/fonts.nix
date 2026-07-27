{ pkgs, ... }: {
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    material-design-icons
    vista-fonts
    google-fonts
    corefonts
    inter
  ];
}
