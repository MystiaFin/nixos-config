{pkgs, ... }:

{
  home.packages = with pkgs; [
    playerctl       # For mpris (music)
    blueman         # For bluetooth click
    pavucontrol     # For audio click
    wleave          # For the Arch icon click (Logout menu)
    font-awesome    # For the icons in your config
  ];

  programs.waybar = {
    enable = true;

    style = builtins.readFile ./waybar/styles.css;

    settings = {
      mainBar = builtins.fromJSON (builtins.readFile ./waybar/config.json);
    };
  };
}
