-- diff mode turns wrap off on its own, this keeps it on
vim.opt.diffopt:append("followwrap")

-- unchanged lines stay unfolded, so the whole file shows around each change
vim.opt.diffopt:append("context:99999")

require("diffview").setup({
	-- tells deleted lines apart from changed ones
	enhanced_diff_hl = true,

	-- old on top, new below, so each side gets the full width
	view = {
		default = { layout = "diff2_vertical", winbar_info = true },
		file_history = { layout = "diff2_vertical", winbar_info = true },
	},

	file_panel = {
		win_config = { width = 30 },
	},

	hooks = {
		-- only in diff windows, normal editing keeps its options
		diff_buf_win_enter = function()
			vim.opt_local.wrap = true
			vim.opt_local.relativenumber = false
		end,
	},
})
