{ pkgs, ... }:

{
  programs.neovim.plugins = [
    {
      plugin = pkgs.vimPlugins.nvim-lspconfig;
      type = "lua";
      config = ''
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

        -- Ensure these tables exist if they are not standard API
        vim.lsp.config = vim.lsp.config or {}
        
        vim.lsp.config.intelephense = {
            cmd = { "intelephense", "--stdio" },
            filetypes = { "php", "blade" },
            root_markers = { "composer.json", ".git" },
            settings = {
                intelephense = {
                    files = { maxSize = 5000000 },
                    environment = { phpVersion = "8.2" },
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
            cmd = { "qmlls" },
            filetypes = { "qmljs", "qml" },
        }

        vim.lsp.config.nixd = {
            cmd = { "nixd" },
            filetypes = { "nix" },
            root_markers = { "flake.nix", ".git" },
            settings = {
                nixd = {
                    nixpkgs = {
                        expr = "import <nixpkgs> { }",
                    },
                    formatting = {
                        command = { "nixpkgs-fmt" },
                    },
                },
            },
        }

        -- Added KDL configuration
        vim.lsp.config.kdl_lsp = {
            cmd = { "kdl-lsp" },
            filetypes = { "kdl" },
            root_markers = { ".git" },
        }

        -- Note: Ensure 'vim.lsp.enable' is defined in your environment
        -- or this line will error.
        vim.lsp.enable({
            "intelephense",
            "html",
            "cssls",
            "tailwindcss",
            "qmlls",
            "lua_ls",
            "nixd",
            "kdl_lsp" -- Added here
        })

        vim.filetype.add({
            pattern = {
                ['.*%.blade%.php'] = 'blade',
                ['.*%.kdl'] = 'kdl', -- Added filetype detection
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
      '';
    }
  ];
}
