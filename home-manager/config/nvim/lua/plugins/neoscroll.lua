return {
  "karb94/neoscroll.nvim",
  event = "BufRead",
  opts = {},
  config = function()
    require('neoscroll').setup({
      mappings = {
        '<C-u>', '<C-d>',
      },
      hide_cursor = false,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      duration_multiplier = 0.5,
      easing = 'linear',
      pre_hook = nil,
      post_hook = nil,
      performance_mode = false,
      ignored_events = {
        'WinScrolled', 'CursorMoved'
      },
    })
  end,
}
