{ pkgs, ... }:

{
  programs.neovim.plugins = [
    {
      plugin = pkgs.vimPlugins.autoclose-nvim;
      type = "lua";
      config = ''
        require("autoclose").setup({
            options = {
                disable_auto_comment = true,
                disable_when_touch = false,
                pairs = {
                    ["'"] = "'",
                    ['"'] = '"',
                    ["`"] = "`",
                    ["("] = ")",
                    ["["] = "]",
                    ["{"] = "}",
                },
            },
        })
      '';
    }
  ];
}
