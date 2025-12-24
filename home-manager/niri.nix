{ config, pkgs, device, ... }:

{
  xdg.configFile."niri/config.kdl".text = ''
    ${if device == "low-end" then ''
      output "eDP-1" {
          mode "1337x768@60"
          scale 1.0
      }
    '' else ''
      output "DP-1" { 
          mode "1920x1080@144"
          scale 1.2
      }
    ''}

    ${builtins.readFile ./config/niri.kdl}
  '';
}
