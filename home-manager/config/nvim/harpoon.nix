{ pkgs, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    plenary-nvim
    {
      plugin = harpoon2;
      type = "lua";
      config = ''
        local harpoon = require("harpoon")
        
        harpoon:setup({
            menu = {
                width = vim.api.nvim_win_get_width(0) - 4,
            },
            global_settings = {
                save_on_toggle = false,
                save_on_change = true,
                enter_on_sendcmd = false,
                tmux_autoclose_windows = false,
                excluded_filetypes = { "harpoon" },
                mark_branch = false,
                use_relative_path = true,
            },
        })

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set("n", "<M-1>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<M-2>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<M-3>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<M-4>", function() harpoon:list():select(4) end)

        -- Toggle previous & next buffers
        vim.keymap.set("n", "<Tab>", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<S-Tab>", function() harpoon:list():next() end)
      '';
    }
  ];
}
