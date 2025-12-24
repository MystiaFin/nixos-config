{ pkgs, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    plenary-nvim
    {
      plugin = harpoon2;
      type = "lua";
      config = ''
        require("harpoon").setup({
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
      '';
    }
  ];
}
