return {
  "lervag/vimtex",
  lazy = false,
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    vim.g.vimtex_view_method = "zathura"
  end
}
