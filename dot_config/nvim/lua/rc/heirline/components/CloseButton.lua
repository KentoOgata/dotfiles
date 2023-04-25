return {
  condition = function(self)
    return not vim.bo.modified
  end,
  update = { 'WinNew', 'WinClosed', 'BufEnter' },
  { provider = ' ' },
  {
    provider = ' ',
    hl = { fg = 'gray' },
    on_click = {
      callback = function(_, minwid)
        vim.api.nvim_win_close(minwid, true)
      end,
      minwid = function()
        return vim.api.nvim_get_current_win()
      end,
      name = 'heirline_winbar_close_button',
    },
  },
}
