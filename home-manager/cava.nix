{ config, pkgs, ... }:

{
  xdg.configFile."cava/config".text = ''
    [general]
    bars = 0
    bar_width = 2
    bar_spacing = 1

    [input]
    method = pulse
    source = auto

    [output]
    method = noncurses

    [color]
    gradient = 1
    gradient_color_1 = '#59cc33'
    gradient_color_2 = '#80cc33'
    gradient_color_3 = '#a6cc33'
    gradient_color_4 = '#cccc33'
    gradient_color_5 = '#cca633'
    gradient_color_6 = '#cc8033'
    gradient_color_7 = '#cc5933'
    gradient_color_8 = '#cc3333'
  '';

  xdg.configFile."cava/config-raw".text = ''
    [general]
    bars = 20

    [input]
    method = pulse
    source = auto

    [output]
    method = raw
    raw_target = /dev/stdout
    data_format = ascii
    ascii_max_range = 100
    bar_delimiter = 59
    frame_delimiter = 10
  '';
}
