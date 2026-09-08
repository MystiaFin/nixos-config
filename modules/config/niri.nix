{ config, pkgs, lib, ... }:

let
  cfg = config.custom.niri;
  rawConfig = builtins.readFile ./niri.kdl;
  finalConfig = builtins.replaceStrings [ "@TERMINAL@" ] [ cfg.terminal ] rawConfig;
in {
  options.custom.niri = {
    outputConfig = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Niri output configuration block";
    };

    terminal = lib.mkOption {
      type = lib.types.str;
      default = "kitty";
      description = "Terminal command for niri keybind";
    };
  };

  config = {
    xdg.configFile."niri/config.kdl".text = ''
      spawn-at-startup "tmux-boot"

      ${cfg.outputConfig}

      ${finalConfig}
    '';
  };
}
