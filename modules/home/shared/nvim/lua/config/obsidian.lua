require("obsidian").setup({
	legacy_commands = false,
	workspaces = {
		{
			name = "personal",
			path = "~/Obsidian/Site of Grace",
		},
	},
	ui = {
		enable = false
	},
	attachments = {
		folder = "assets/tmp",
	},
})
