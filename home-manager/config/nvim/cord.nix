{ pkgs, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = cord-nvim; 
      type = "lua";
      config = ''
        require('cord').setup({})
      '';
    }
  ];
}
