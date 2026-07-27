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
      spawn-at-startup "bash" "-c" "${pkgs.tmux}/bin/tmux new-session -d -s warm-up; sleep 6; ${pkgs.tmux}/bin/tmux kill-session -t warm-up"

      ${cfg.outputConfig}

      ${finalConfig}
    '';
  };
}
