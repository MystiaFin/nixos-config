{ config, pkgs, device, ... }:

let
  terminalCmd = if device == "low-end" then "foot" else "kitty";
  rawConfig = builtins.readFile ./config/niri.kdl;
  finalConfig = builtins.replaceStrings [ "@TERMINAL@" ] [ terminalCmd ] rawConfig;
in

{
  xdg.configFile."niri/config.kdl".text = ''
    ${if device == "low-end" then ''
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
