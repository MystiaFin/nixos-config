require("snacks").setup {
	image = {
		enabled = true, -- this is required
		doc = {
			max_width = 50,
			max_height = 20,
		},
		resolve = function(path, src)
			local vault = vim.fn.expand("~/Obsidian/Site of Grace")
			local filename = vim.fn.fnamemodify(src, ":t")
			local results = vim.fs.find(filename, { path = vault, type = "file" })
			if results and results[1] then
				return results[1]
			end
		end,
	},
}
