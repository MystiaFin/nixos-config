{ config, pkgs, device, ... }:

let
  terminalCmd = if device == "thinkpad" then "foot" else "kitty";
  rawConfig = builtins.readFile ./config/niri.kdl;
  finalConfig = builtins.replaceStrings [ "@TERMINAL@" ] [ terminalCmd ] rawConfig;
in

{
  xdg.configFile."niri/config.kdl".text = ''
    ${if device == "thinkpad" then ''
      output "eDP-1" {
          mode "1337x768@60"
          scale 1.0
      }
    '' else ''
      output "eDP-1" { 
          mode "1920x1080@144"
          scale 1.25
      }
    ''}

    ${finalConfig}
  '';
}
