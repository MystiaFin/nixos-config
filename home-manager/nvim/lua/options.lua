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

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Neorg
vim.keymap.set('n', "<leader>n", ":Neorg workspace notes<CR>")

vim.o.winborder = "rounded"

