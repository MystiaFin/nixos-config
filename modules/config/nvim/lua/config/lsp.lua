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

local function read(path)
	local f = io.open(path)
	if not f then
		return nil
	end
	local text = f:read("a")
	f:close()
	return text
end

-- a kernel (or any bare-metal crate) targets `*-none*` or rebuilds core with build-std;
-- rustup already picks its toolchain, this only fixes what rust-analyzer checks
local function bare_metal_settings(root)
	local toolchain = read(root .. "/rust-toolchain.toml") or read(root .. "/rust-toolchain") or ""
	local cargo = read(root .. "/.cargo/config.toml") or read(root .. "/.cargo/config") or ""
	local target = toolchain:match('"([%w_.-]+%-none[%w_.-]*)"')
	if not (target or cargo:find("%-none") or cargo:find("build%-std")) then
		return nil
	end
	-- there's no `test` crate and the kernel brings its own panic handler,
	-- so checking test targets only produces bogus errors
	local settings = { check = { allTargets = false } }
	-- rust-analyzer already reads build.target from .cargo/config, so only fill it in when that's missing
	if target and not cargo:find("target%s*=") then
		settings.cargo = { target = target }
	end
	return settings
end

vim.lsp.config.rust_analyzer = {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", "rust-project.json", ".git" },
	settings = {
		["rust-analyzer"] = {
			check = {
				command = "clippy",
			},
		},
	},
	on_init = function(client)
		local extra = client.root_dir and bare_metal_settings(client.root_dir)
		if extra then
			-- a new table, so other rust projects keep the plain settings
			client.settings = vim.tbl_deep_extend("force", client.settings, { ["rust-analyzer"] = extra })
			client:notify("workspace/didChangeConfiguration", { settings = client.settings })
		end
	end,
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
	cmd = { "qmlls" },
	filetypes = { "qml" },
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

vim.lsp.config.clangd = {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--header-insertion=iwyu",
	},
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	root_markers = {
		"compile_commands.json",
		"compile_flags.txt",
		".clangd",
		".git",
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
	"rust_analyzer",
	"clangd",

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
