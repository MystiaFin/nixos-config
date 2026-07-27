{ config, pkgs, ... }: {
  xdg.configFile."quickshell".source = ./../../shell;
}
