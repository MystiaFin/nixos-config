{ pkgs, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = cord-nvim; 
      type = "lua";
      # ERROR WAS HERE: 'opts' is not valid in Home Manager.
      # We must use 'config' string instead.
      config = ''
        require('cord').setup({})
      '';
    }
  ];
}
