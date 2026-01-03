{ pkgs, ... }:

{
  imports = [
    ./config/nvim/autoclose.nix
    ./config/nvim/autotag.nix
    ./config/nvim/catppuccin.nix
    ./config/nvim/dashboard.nix
    ./config/nvim/gitsigns.nix
    ./config/nvim/harpoon.nix
    ./config/nvim/indent-blankline.nix
    ./config/nvim/lsp.nix
    ./config/nvim/lualine.nix
    ./config/nvim/neoscroll.nix
    ./config/nvim/noice.nix
    ./config/nvim/oil.nix
    ./config/nvim/telescope.nix
    ./config/nvim/treesitter.nix
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    extraLuaConfig = ''
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
      vim.o.winborder = "rounded"

      -- Global Keymaps
      vim.g.mapleader = " "
      
      -- General Mappings
      vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
      vim.keymap.set("n", "<leader>w", ":w<CR>")
      vim.keymap.set("n", "<leader>q", ":cclose<CR>", { silent = true })
      
      -- Visual Mode Mappings (Move lines up/down)
      vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { silent = true })
      vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { silent = true })
    '';

    extraPackages = with pkgs; [
      git
      lua-language-server
      intelephense
      vscode-langservers-extracted
      tailwindcss-language-server
      ripgrep
      fd
      gcc
      kdePackages.qtdeclarative
      nixd
      nixpkgs-fmt
    ];
  };
}
