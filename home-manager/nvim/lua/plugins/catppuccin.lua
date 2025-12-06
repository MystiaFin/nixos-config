return {
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
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
				telescope = true,
				treesitter = true,
				nvimtree = true,
				which_key = true,
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
	priority = 1000,
}
