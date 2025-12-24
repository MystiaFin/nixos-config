{ pkgs, ... }:

{
  programs.neovim.plugins = [
    {
      plugin = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
        p.lua
        p.typescript
        p.javascript
        p.html
        p.css
        p.json
        p.tsx
      ]);
      
      type = "lua";
      config = ''
        require("nvim-treesitter.configs").setup({
           highlight = {
              enable = true,
           },
        })

        vim.defer_fn(function()
           vim.cmd("TSEnable highlight")
        end, 100)
      '';
    }
  ];
}
