require('options')

-- Initialize plugins
require("oil").setup()
require("telescope").setup()
require("typst-preview").setup()

-- User config
require('config/themes/catppuccin')
require('config/themes/gruvbox')
require('config/themes/gruvbox-baby')
require('config/treesitter')
require('config/lsp')
require('config/lualine')
require('config/presence')
require('config/autopairs')
require('config/autotag')
require('config/harpoon')
require('config/neoscroll')
require('config/gitsigns')
require('config/dashboard')
require('config/ibl')
require('config/vimtex')
require('config/themery')
require('config/cmp')
require('config/obsidian')
require("config/render-markdown")
require("config/snacks")
require("config/avante")
require("config/copilot")
require("config/image")

require("jupytext").setup({
	style = "markdown",
	output_extension = "md",
	force_ft = "markdown",
})

vim.g.molten_auto_init_behavior = "init"
vim.g.molten_auto_open_output = false
vim.g.molten_image_provider = "image.nvim"
vim.g.molten_image_location = "virt"
vim.g.molten_output_win_max_height = 20
vim.g.molten_virt_lines_off_by_1 = true
vim.g.molten_virt_text_max_lines = 20
vim.g.molten_virt_text_output = true
vim.g.molten_wrap_output = true

local function run_notebook_cell()
	local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
	local start_line = vim.fn.search([[^```\S]], "bcnW")
	local end_line = vim.fn.search([[^```\s*$]], "nW")

	if start_line == 0 or end_line == 0 or cursor_line > end_line then
		vim.notify("Cursor is not inside a notebook code cell", vim.log.levels.WARN)
		return
	end

	vim.fn.MoltenEvaluateRange(start_line + 1, end_line - 1)
end

vim.keymap.set("n", "<leader>ji", "<cmd>MoltenInit<CR>", { desc = "Initialize notebook kernel" })
vim.keymap.set("n", "<leader>jr", run_notebook_cell, { desc = "Run notebook cell" })
vim.keymap.set("v", "<leader>jr", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Run notebook selection" })
vim.keymap.set("n", "<leader>jl", "<cmd>MoltenEvaluateLine<CR>", { desc = "Run notebook line" })
vim.keymap.set("n", "<leader>jo", "<cmd>noautocmd MoltenEnterOutput<CR>", { desc = "Open notebook output" })
vim.keymap.set("n", "<leader>jh", "<cmd>MoltenHideOutput<CR>", { desc = "Hide notebook output" })
vim.keymap.set("n", "<leader>jd", "<cmd>MoltenDelete<CR>", { desc = "Delete notebook output" })

local function initialize_notebook(event)
	vim.schedule(function()
		local kernels = vim.fn.MoltenAvailableKernels()
		local kernel_name
		local file = io.open(event.file, "r")

		if file then
			local ok, notebook = pcall(vim.json.decode, file:read("*a"))
			file:close()
			if ok and notebook.metadata and notebook.metadata.kernelspec then
				kernel_name = notebook.metadata.kernelspec.name
			end
		end

		if not vim.tbl_contains(kernels, kernel_name) then
			local environment = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
			kernel_name = environment and vim.fs.basename(environment) or nil
		end

		if kernel_name and vim.tbl_contains(kernels, kernel_name) then
			vim.cmd("MoltenInit " .. kernel_name)
		end
		vim.cmd("MoltenImportOutput")
	end)
end

vim.api.nvim_create_autocmd("BufAdd", {
	pattern = "*.ipynb",
	callback = initialize_notebook,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.ipynb",
	callback = function(event)
		if vim.v.vim_did_enter ~= 1 then
			initialize_notebook(event)
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.ipynb",
	callback = function()
		if require("molten.status").initialized() == "Molten" then
			vim.cmd("MoltenExportOutput!")
		end
	end,
})

vim.keymap.set("i", "<C-t>", function()
  local time = os.date("%H:%M")
  vim.api.nvim_put({ "## " .. time }, "c", true, true)
end, { desc = "Insert current time" })
