-- the amane colorscheme: catppuccin's highlight groups, painted with the
-- palette amane derives from the wallpaper, and repainted when it changes

local M = {}

local folder = vim.fn.expand("~/.local/state/amane")
local file = "nvim-palette.lua"

local watcher = nil

-- also read by the amane lualine theme
function M.read()
	local ok, colors = pcall(dofile, folder .. "/" .. file)

	if ok and type(colors) == "table" then
		return colors
	end
end

-- amane writes by renaming a new file over the old one, so the folder is watched
local function watch()
	if watcher then
		return
	end

	watcher = vim.uv.new_fs_event()

	watcher:start(folder, {}, vim.schedule_wrap(function(_, name)
		if name == file and vim.g.colors_name == "amane" then
			M.load()

			-- :colorscheme would announce this itself; lualine redraws its theme on it
			vim.api.nvim_exec_autocmds("ColorScheme", { pattern = "amane" })
		end
	end))
end

function M.load()
	local colors = M.read()

	if not colors then
		vim.notify("amane: no palette yet, turn on the Neovim integration in amane's settings", vim.log.levels.WARN)
		return
	end

	-- latte is catppuccin's light flavour, mocha a dark one; amane replaces their colors
	local flavour = colors.light and "latte" or "mocha"

	require("catppuccin").setup({
		flavour = flavour,
		transparent_background = true,
		term_colors = true,
		color_overrides = { [flavour] = colors.palette },
		styles = {
			comments = { "italic" },
			conditionals = { "italic" },
			functions = { "italic" },
			keywords = { "italic" },
			strings = { "italic" },
		},
		integrations = {
			cmp = true,
			gitsigns = true,
			telescope = false,
			treesitter = true,
			nvimtree = true,
			which_key = true,
		},
		custom_highlights = function(c)
			local blend = require("catppuccin.utils.colors").blend
			local added = colors.added

			return {
				-- strings took the green slot, so added lines get the real green back
				Added = { fg = added },
				diffAdded = { fg = added },
				["@diff.plus"] = { fg = added },
				DiffAdd = { bg = blend(added, c.base, 0.18) },
				GitSignsAdd = { fg = added },
				DiagnosticOk = { fg = added },

				-- the editor's own interface carries the wallpaper's color, like the keywords;
				-- catppuccin gives these to blue, which here is the functions' violet
				DashboardHeader = { fg = c.mauve },
				DashboardIcon = { fg = c.mauve, bold = true },
				Directory = { fg = c.mauve },
				Title = { fg = c.mauve, bold = true },
				FloatTitle = { fg = c.mauve, bold = true },
				Folded = { fg = c.mauve },
				MoreMsg = { fg = c.mauve },
				Question = { fg = c.mauve },
				CursorLineNr = { fg = c.mauve },

				NormalFloat = { bg = "NONE" },
				FloatBorder = { bg = "NONE" },
			}
		end,
	})

	require("catppuccin").load(flavour)

	-- lualine keeps a loaded theme, so the next redraw has to read it again
	package.loaded["lualine.themes.amane"] = nil

	vim.g.colors_name = "amane"

	watch()
end

return M
