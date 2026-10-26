require("neogit").setup({
	-- diffs open in diffview instead of neogit's own view
	integrations = {
		diffview = true,
		telescope = true,
	},
})

vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Open Neogit" })
