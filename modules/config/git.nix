{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user.name = "mystiafin";
      user.email = "cytrsx01@gmail.com";
    };
  };
}
