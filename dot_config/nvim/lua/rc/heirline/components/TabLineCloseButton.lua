return {
  condition = function(self)
    -- return not vim.bo[self.bufnr].modified
    return not vim.api.nvim_buf_get_option(self.bufnr, 'modified')
  end,
  { provider = ' ' },
  {
    -- ✗    
    provider = ' ',
    hl = { fg = 'gray' },
    on_click = {
      callback = function(_, minwid)
        vim.schedule(function()
          vim.api.nvim_buf_delete(minwid, { force = false })
        end)
        vim.cmd.redrawtabline()
      end,
      minwid = function(self)
        return self.bufnr
      end,
      name = 'heirline_tabline_close_buffer_callback',
    },
  },
}
