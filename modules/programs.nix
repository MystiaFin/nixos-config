{ lib, pkgs, hw_file, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    git
    xwayland-satellite
    catppuccin-cursors.mochaDark
    sddm-astronaut
  ] ++ lib.optionals (hw_file == "nixos") [
    opentabletdriver
    mangohud
    protonup-qt
  ];

  programs.niri.enable = true;
	programs.fish.enable = true;
  programs.mtr.enable = true;
  programs.dconf.enable = true;
  programs.bash.enable = true;
}
