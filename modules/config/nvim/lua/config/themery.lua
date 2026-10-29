require("themery").setup({
	themes = {
		{
			name = "Amane",
			colorscheme = "amane",
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
