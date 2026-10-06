{ pkgs, ... }: {
  home.packages = with pkgs; [
    tree-sitter
    nano
    brightnessctl
    wl-clipboard
    cliphist
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
    wf-recorder
    pulseaudio # only for pactl, pipewire-pulse stays the server
		python3Packages.pdf2docx
		sqlite
		visidata
  ];
}
