{
  pkgs,
  ...
}:

{
  programs.emacs = {
    enable = true;
    # native wayland build, the X11 one runs through xwayland under niri
    package = pkgs.emacs-pgtk;
  };
}
