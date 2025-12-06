{ pkgs, ... }:

let
  wallpaper = ../wallpapers/wallpaper_2.jpg; 
in

{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${wallpaper}" ];
      wallpaper = [ ",${wallpaper}" ];
    };
  };
  home.packages = with pkgs; [
    waybar
    hyprpaper
    wofi
    grim
    slurp
    wl-clipboard
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    
    settings = {
      monitor = ",1920x1080@144,auto,1.25";

      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "wofi --show drun";
      "$mainMod" = "SUPER";

      # --- Autostart ---
      exec-once = [
        "nm-applet &"
        "waybar & hyprpaper"
        "fcitx5"
        "[workspace special:warmup silent] kitty --class=kitty-warmup"
      ];

      # --- General ---
      general = {
        gaps_in = 6;
        gaps_out = 10;
        border_size = 0;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      # --- Decoration ---
      decoration = {
        rounding = 7;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = false;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = false;
          size = 7;
          passes = 3;
          new_optimizations = true;
        };
      };

      # --- Animations ---
      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.0"
          "winIn, 0.15, 1.0, 0.2, 1.0"
          "winOut, 0.2, 0.0, 0.3, 1.0"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 3, wind, slide"
          "windowsIn, 1, 3, winIn, slide"
          "windowsOut, 1, 2, winOut, slide"
          "windowsMove, 1, 2, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 5, default"
          "workspaces, 1, 3, wind"
        ];
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0.5;

        touchpad = {
          scroll_factor = 0.2;
          natural_scroll = true;
        };
      };

      # --- Layouts ---
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = true;
      };

      # --- Window Rules ---
      windowrulev2 = [
        "opacity 0.9 override, class:^(rofi)$"
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "float, class:(nm-connection-editor)"
        "size 800 600, class:(nm-connection-editor)"
        "center, class:(nm-connection-editor)"
        "float, class:^(steam)$"
        "float, size 300 400, move 100%-310 10, class:^(blueman-manager)$"
        "float, title:^(Sign in.*)$"
        "center, title:^(Sign in.*)$"
        "float, class:^(rofi)$"
        "center, class:^(rofi)$"
        "workspace special, class:^(rofi)$"
        "size 1 1, class:^(kitty-warmup)$"
      ];
      
      xwayland = {
        force_zero_scaling = true;
      };

      # --- Keybindings ---
      bind = [
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod SHIFT, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod SHIFT, T, exec, $menu"
        "SUPER, W, exec, pkill waybar && waybar &"
        "SUPER, V, exec, hyprctl dispatch togglefloating && hyprctl dispatch resizeactive exact 680 480 && hyprctl dispatch centerwindow"
        
        # Focus
        "$mainMod, h, movefocus, l"
        "$mainMod, j, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, l, movefocus, d"

        # Move
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, j, movewindow, d"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, l, movewindow, r"

        # Resize (Note: standard bind)
        "$mainMod CTRL, h, resizeactive, -20 0"
        "$mainMod CTRL, l, resizeactive, 20 0"
        "$mainMod CTRL, k, resizeactive, 0 -20"
        "$mainMod CTRL, j, resizeactive, 0 20"
        
        # Workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Special Workspace
        "$mainMod, S, togglespecialworkspace, magic"

        # Scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        
        # Screenshot
        "$mainMod SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy"
        "$mainMod, Print, exec, grim - | wl-copy"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Multimedia keys (bindel = repeat)
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      # Media keys (bindl = locked/works when locked)
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
    };
  };
}
