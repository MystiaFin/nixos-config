{ config, pkgs, inputs, ... }:

{
  imports = [
    ./niri.nix
    ./foot.nix
  ];

  home.packages = with pkgs; [
    foot
    inputs.helium-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
  ];

  home.sessionVariables = {
    TERMINAL = "foot";
  };

  # spotify's nix wrapper only picks wayland when this is set, through xwayland it never knows it's hidden
  xdg.desktopEntries.spotify = {
    name = "Spotify";
    genericName = "Music Player";
    icon = "spotify-client";
    exec = "env NIXOS_OZONE_WL=1 spotify %U";
    categories = [ "Audio" "Music" "Player" "AudioVideo" ];
    mimeType = [ "x-scheme-handler/spotify" ];
  };
}
