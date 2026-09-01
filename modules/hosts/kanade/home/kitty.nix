{ config, pkgs, ... }:

let
  mkKittyConf = pkgs.writeText "kitty.conf" ''
    font_family JetBrainsMono Nerd Font
    font_size 13

    background_opacity 0.92

    window_padding_width 8

    cursor_shape block
    cursor_blink_interval 0
    shell_integration no-cursor

    allow_remote_control socket-only
    listen_on unix:@quickshell-kitty

    tab_bar_edge top
    tab_bar_style powerline
    tab_bar_min_tabs 2

    scrollback_lines 10000

    enable_audio_bell no

    # Catppuccin Mocha
    background #1e1e2e
    foreground #cdd6f4
    cursor #f5e0dc
    cursor_text_color #1e1e2e
    selection_background #585b70
    selection_foreground #cdd6f4
    active_border_color #cba6f7
    inactive_border_color #313244
    active_tab_background #cba6f7
    active_tab_foreground #1e1e2e
    inactive_tab_background #181825
    inactive_tab_foreground #6c7086
    tab_bar_background #11111b

    color0 #45475a
    color1 #f38ba8
    color2 #a6e3a1
    color3 #f9e2af
    color4 #89b4fa
    color5 #f5c2e7
    color6 #94e2d5
    color7 #bac2de
    color8 #585b70
    color9 #f38ba8
    color10 #a6e3a1
    color11 #f9e2af
    color12 #89b4fa
    color13 #f5c2e7
    color14 #94e2d5
    color15 #a6adc8

    include /home/mystiafin/.config/quickshell/terminal-colors-kitty.conf
  '';
in {
  xdg.configFile."kitty/kitty.conf".source = mkKittyConf;
}
