require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true,
    term_colors = true,
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        functions = { "italic" },
        keywords = { "italic" },
        strings = { "italic" },
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
    },
    integrations = {
        cmp = true,
        gitsigns = true,
				telescope = false, -- SET THIS TO FALSE
        treesitter = true,
        nvimtree = true,
        which_key = true,
    },
    -- Force transparency every time Catppuccin loads
    custom_highlights = function(colors)
        return {
            NormalFloat = { bg = "NONE" },
            FloatBorder = { bg = "NONE" },
            TelescopeNormal = { bg = "NONE" },
            TelescopeBorder = { bg = "NONE" },
            TelescopePromptNormal = { bg = "NONE" },
            TelescopePromptBorder = { bg = "NONE" },
            TelescopeResultsNormal = { bg = "NONE" },
            TelescopeResultsBorder = { bg = "NONE" },
            TelescopePreviewNormal = { bg = "NONE" },
            TelescopePreviewBorder = { bg = "NONE" },
        }
    end,
})
