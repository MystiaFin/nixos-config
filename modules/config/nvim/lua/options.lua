-- Numberings
vim.o.number = true
vim.o.relativenumber = true

-- Text format
vim.o.wrap = false
vim.o.tabstop = 2

-- General options
vim.o.swapfile = false
vim.o.guicursor = ""
vim.o.ignorecase = true
vim.o.scrolloff = 10

-- Keymaps
vim.g.mapleader = " "
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("n", "<leader>q", ":cclose<CR>", { silent = true })

-- Obsidian
vim.keymap.set("n", "<leader>b", ":Obsidian backlinks<CR>", { silent = true})

vim.keymap.set("n", "<leader>p", function()
	-- 1. Setup paths based on your obsidian.nvim config
	local vault_path = vim.fn.expand("~/Obsidian/Site of Grace")
	local folder = "assets/tmp"
	local abs_folder = vault_path .. "/" .. folder
	
	-- Ensure the attachments directory exists
	vim.fn.mkdir(abs_folder, "p")
	
	-- 2. Generate filename based on timestamp
	local filename = os.date("%Y%m%d%H%M%S") .. ".png"
	local filepath = abs_folder .. "/" .. filename
	
	-- 3. Execute wl-paste directly, piping binary to file
	local cmd = string.format("wl-paste --no-newline --type image/png > '%s'", filepath)
	vim.fn.system(cmd)
	
	-- 4. Check success and insert into buffer
	if vim.v.shell_error == 0 then
		-- Create the markdown link (adjust formatting if you prefer standard Obsidian [[links]])
		local markdown = string.format("![%s](%s/%s)", filename, folder, filename)
		
		-- Insert at cursor
		vim.api.nvim_put({markdown}, "c", true, true)
		vim.notify("Image pasted successfully: " .. filename, vim.log.levels.INFO)
	else
		vim.notify("Failed to paste. Is wl-paste missing from Neovim's PATH?", vim.log.levels.ERROR)
	end
end, { desc = "Force Wayland Image Paste" })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.o.winborder = "rounded"

vim.keymap.set("n", "<C-c>", function()
  local line = vim.api.nvim_get_current_line()
  local filename = line:match("!%[%[(.-)%]%]") or line:match("!%[.-%]%((.-)%)")
  if not filename then
    return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, false, true), "n", false)
  end

  local current_dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
  local vault_root = vim.fn.fnamemodify(vim.fn.finddir(".obsidian", current_dir .. ";"), ":h")

  local path = current_dir .. "/attachments/" .. filename
  if vim.fn.filereadable(path) == 0 then
    path = vault_root .. "/attachments/" .. filename
  end

	vim.cmd('silent !wl-copy --type image/png < "' .. path .. '"')
	vim.notify("Image " .. filename .. " copied")
end, {})

vim.api.nvim_create_user_command("Chat", "AvanteToggle", {})
