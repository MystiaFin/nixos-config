{ config, pkgs, lib, ... }:

{
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
  };

  wayland.windowManager.sway = {
    enable = true;
    package = null;
    checkConfig = false;

    config = {
      modifier = "Mod4";
      terminal = "foot";

      gaps = {
        inner = 6;
        outer = 0;
      };

      window = {
        titlebar = false;
        border = 2;
      };
      floating = {
        titlebar = false;
        border = 2;
      };

      startup = [
        { command = "qs"; }
      ];

      input = {
        "type:touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
        };
        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "-0.3";
        };
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_options = "caps:escape";
        };
      };

      keybindings = lib.mkOptionDefault {
        "Mod4+Return" = "exec foot";
        "Mod4+q" = "kill";
        "Mod4+Shift+e" = "exit";
        "Mod4+d" = "exec wofi --show drun";

        # Launcher Toggle
        "Control+space" = "exec qs ipc call launcher toggle";

        # Screenshot
        "Mod4+Shift+s" = "exec grim -g \"$(slurp)\" - | wl-copy";
        "Mod4+Print" = "exec grim - | wl-copy";

        # Audio/Brightness
        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86MonBrightnessUp" = "exec brightnessctl set +10%";
        "XF86MonBrightnessDown" = "exec brightnessctl set 10%-";
      };

      colors = {
        focused = {
          border = "#7fc8ff";
          background = "#7fc8ff";
          text = "#1e1e2e";
          indicator = "#7fc8ff";
          childBorder = "#7fc8ff";
        };
        focusedInactive = {
          border = "#505050";
          background = "#1e1e2e";
          text = "#cdd6f4";
          indicator = "#505050";
          childBorder = "#505050";
        };
        unfocused = {
          border = "#505050";
          background = "#1e1e2e";
          text = "#cdd6f4";
          indicator = "#505050";
          childBorder = "#505050";
        };
        urgent = {
          border = "#9b0000";
          background = "#1e1e2e";
          text = "#ffffff";
          indicator = "#9b0000";
          childBorder = "#9b0000";
        };
      };

      bars = [ ];
      output = {
        "*" = { bg = "#1e1e2e solid_color"; };
      };
    };

    extraConfig = ''
            default_border pixel 2
            default_floating_border pixel 2
      			seat seat0 xcursor_theme "catppuccin-mocha-dark-cursors" 24
    '';
  };
}
