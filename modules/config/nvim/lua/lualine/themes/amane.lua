-- lualine's 'auto' theme looks for one named after the colorscheme; this one
-- copies the tmux bar amane draws: the mode in the accent, then the theme's
-- selected surface, then the transparent middle

local colors = require("config.amane").read()

-- a palette from before amane wrote the shell's colors falls back to catppuccin's
if not colors or not colors.ui then
	return require("catppuccin.utils.lualine")()
end

local ui = colors.ui
local palette = colors.palette

local function mode(fill)
	return {
		a = { bg = fill, fg = ui.on_accent, gui = "bold" },
		b = { bg = ui.segment, fg = ui.text },
		c = { bg = "NONE", fg = ui.text },
	}
end

-- normal matches tmux exactly, the other modes keep a color of their own
return {
	normal = mode(ui.accent),
	insert = mode(palette.green),
	visual = mode(palette.peach),
	replace = mode(palette.red),
	command = mode(palette.yellow),
	inactive = {
		a = { bg = ui.segment, fg = ui.text },
		b = { bg = ui.segment, fg = ui.text },
		c = { bg = "NONE", fg = palette.overlay2 },
	},
}
