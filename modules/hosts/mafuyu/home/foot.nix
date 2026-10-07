{ config, pkgs, ... }:

let
  ini = pkgs.lib.generators.toINI { };
  cfg = ini {
    main = {
      font = "JetBrainsMono Nerd Font:size=13";
      include = "${config.home.homeDirectory}/.local/state/amane/terminal-colors-foot.ini";
      pad = "8x8";
    };
    bell = {
      system = false;
      urgent = false;
      notify = false;
    };
    scrollback = {
      lines = 10000;
    };
    cursor = {
      style = "block";
      blink = false;
    };
  };
in {
  xdg.configFile."foot/foot.ini".text = cfg;
}
