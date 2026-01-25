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
