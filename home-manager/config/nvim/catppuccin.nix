{ pkgs, ... }:

{
  programs.neovim.plugins = [
    {
      plugin = pkgs.vimPlugins.catppuccin-nvim;
      type = "lua";
      config = ''
        require("catppuccin").setup({
            flavour = "mocha",
            transparent_background = true,
            term_colors = true,
            integrations = {
                cmp = true,
                gitsigns = true,
                treesitter = true,
                nvimtree = true,
                which_key = true,
                noice = true,
                notify = true,
                telescope = true,
            },
            custom_highlights = function(colors)
                return {
                    TelescopeNormal = { bg = "NONE" },
                    TelescopeBorder = { bg = "NONE" },
                    TelescopePromptNormal = { bg = "NONE" },
                    TelescopePromptBorder = { bg = "NONE" },
                    TelescopeResultsNormal = { bg = "NONE" },
                    TelescopeResultsTitle = { fg = colors.text, bg = "NONE" },
                    NormalFloat = { bg = "NONE" },
                    FloatBorder = { bg = "NONE" },
                    NotifyBackground = { bg = "NONE" },
                }
            end
        })
        vim.cmd.colorscheme("catppuccin")
      '';
    }
  ];
}
