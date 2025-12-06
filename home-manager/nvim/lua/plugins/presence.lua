return {
		"andweeb/presence.nvim",
		event = "VeryLazy",
		config = function()
			require("presence").setup({
				neovim_image_text = "Elaina my beloved",
				main_image = "file",
			})
		end,
}
