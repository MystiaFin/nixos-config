return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("config.dashboard").setup()
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
