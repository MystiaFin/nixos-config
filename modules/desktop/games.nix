{ lib, pkgs, hw_file, ... }:

{
  programs.steam = lib.mkIf (hw_file == "nixos") {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;

    extraPackages = with pkgs; [
      catppuccin-cursors.mochaDark
    ];
  };

  programs.gamemode.enable = lib.mkIf (hw_file == "nixos") true;
}
