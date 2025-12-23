return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		build = ":TSUpdate",
		event = "BufReadPost",
		lazy = false,
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"typescript",
					"javascript",
					"html",
					"css",
					"json",
					"tsx",
				},
				highlight = {
					enable = true,
				},
			})

			vim.defer_fn(function()
				vim.cmd("TSEnable highlight")
			end, 100)
		end,
	},
}
