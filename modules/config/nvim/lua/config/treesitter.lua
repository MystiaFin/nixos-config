require("tree-sitter-manager").setup({
	ensure_installed = {
		"lua",
		"typescript",
		"javascript",
		"html",
		"css",
		"json",
		"tsx",
		"php",
		"svelte",
		"go",
		"markdown",
		"markdown_inline"
	},
	border = nil,
	highlight = true,
})

vim.filetype.add({
	pattern = {
		[".*%.blade%.php"] = "blade",
	},
})
