{ config, pkgs, ... }:

{
  xdg.configFile."niri/config.kdl".source = ./config/niri.kdl;
}
