{ pkgs, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    plenary-nvim
    {
      plugin = telescope-nvim;
      type = "lua";
      config = ''
        require("telescope").setup()
        
        -- Restore Telescope Keymaps
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      '';
    }
  ];
}
