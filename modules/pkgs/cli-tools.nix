{ pkgs, ... }: {
  home.packages = with pkgs; [
    tree-sitter
    nano
    brightnessctl
    wl-clipboard
    htop
    fastfetch
    unzip
    libnotify
    microfetch
    btop
    p7zip
    unrar
    tmux
    blesh
    playerctl
    cava
    cmatrix
    gtk3
    bluez-tools
    cloudflare-warp
    cloudflare-cli
		speedtest-cli
    ffmpeg
  ];
}
