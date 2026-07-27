vim.lsp.config('*', {
	capabilities = require('cmp_nvim_lsp').default_capabilities()
})

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.lsp.config.intelephense = {
	cmd = { "intelephense", "--stdio" },
	filetypes = { "php", "blade" },
	root_markers = { "composer.json", ".git" },
	settings = {
		intelephense = {
			files = { maxSize = 5000000 },
			environment = { phpVersion = "8.2" },
			completion = {
				insertUseDeclaration = true,
			},
		},
	},
}

vim.lsp.config.html = {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html", "blade" },
	root_markers = { "package.json", ".git" },
}

vim.lsp.config.cssls = {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	root_markers = { "package.json", ".git" },
}

vim.lsp.config.tailwindcss = {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = { "html", "css", "blade", "php" },
	root_markers = { "tailwind.config.js", "tailwind.config.ts", ".git" },
	settings = {
		tailwindCSS = {
			experimental = {
				classRegex = {
					"class\\s*=\\s*['\"]([^'\"]*)['\"]",
				},
			},
		},
	},
}

vim.lsp.config.qmlls = {
	cmd = { "/usr/lib/qt6/bin/qmlls" },
	filetypes = { "qmljs", "qml" },
	cmd_env = {
		QML_IMPORT_PATH = "/usr/lib/qt6/qml"
	},
}

vim.lsp.config.gopls = {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.work", "go.mod", ".git" },
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
			},
		},
	},
}


vim.lsp.enable({
	"lua_ls",
	"intelephense",
	"html",
	"cssls",
	"tailwindcss",
	"qmlls",
	"dartls",
	"svelte",
	"ts_ls",
	"nil_ls",
	"gopls",
})

vim.filetype.add({
	pattern = {
		['.*%.blade%.php'] = 'blade',
	},
})

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>gl', "<CMD>cclose<CR>")
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
