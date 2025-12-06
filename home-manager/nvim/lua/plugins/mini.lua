return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		-- Load only the icons module
		require("mini.icons").setup()
	end,
}
