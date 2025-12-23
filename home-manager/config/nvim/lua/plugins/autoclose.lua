return {
	"m4xshen/autoclose.nvim",
	event = "InsertEnter",
	config = function()
		require("autoclose").setup({
			options = {
				disable_auto_comment = true,
				disable_when_touch = false,
				pairs = {
					["'"] = "'",
					['"'] = '"',
					["`"] = "`",
					["("] = ")",
					["["] = "]",
					["{"] = "}",
				},
			},
		})
	end,
}
