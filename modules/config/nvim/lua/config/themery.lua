require("themery").setup({
	themes = {
		{
			name = "Catppuccin Mocha",
			colorscheme = "catppuccin-mocha",
		},
		{
			name = "Catppuccin Latte",
			colorscheme = "catppuccin-latte",
		},
		{
			name = "Gruvbox Dark",
			colorscheme = "gruvbox",
			before = [[vim.o.background = "dark"]],
		},
		{
			name = "Gruvbox Light",
			colorscheme = "gruvbox",
			before = [[vim.o.background = "light"]],
		},
		{
			name = "Gruvbox Baby",
			colorscheme = "gruvbox-baby",
		},
	},
})
