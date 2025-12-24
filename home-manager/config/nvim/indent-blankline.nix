{ pkgs, ... }:

{
  programs.neovim.plugins = [
    {
      plugin = pkgs.vimPlugins.indent-blankline-nvim;
      type = "lua";
      config = ''
        require("ibl").setup({})
      '';
    }
  ];
}
