{ pkgs, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    nui-nvim
    nvim-notify
    {
      plugin = noice-nvim;
      type = "lua";
      config = ''
        require("notify").setup({
            background_colour = "#000000",
            render = "compact",
            stages = "fade",
            timeout = 2000,
            max_width = 60,
            max_height = 20,
        })

        require("noice").setup({
            views = {
                notify = {
                    size = { width = 80, height = 6 },
                    position = { row = "100%", col = "100%" },
                    border = { style = "rounded" },
                },
                cmdline_popup = {
                    position = {
                        row = "50%",
                        col = "50%",
                    },
                    size = {
                        width = 80,
                        height = 1,
                    },
                    border = {
                        style = "rounded",
                        padding = { 0, 0 },
                    },
                    win_options = {
                        winblend = 10,
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                    },
                },
            },
            presets = {
                bottom_search = false,
                command_palette = true,
                long_message_to_split = false,
            },
        })

        vim.keymap.set("n", "<leader>l", function()
            require("notify").dismiss({ silent = true, pending = true })
        end, { desc = "Dismiss all notifications" })
      '';
    }
  ];
}
