{ pkgs, ... }:

{
  programs.neovim.plugins = [
    {
      # We use the special 'withPlugins' function here
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
           -- ensure_installed is NOT needed because Nix handles it
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
