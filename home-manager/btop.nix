{
  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      color_theme = "catppuccin_mocha";
    };
  };

  xdg.configFile."btop/themes/catppuccin_mocha.theme".source =
    ./config/btop/catppuccin_mocha.theme;
}

