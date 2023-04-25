return {
  {
    condition = function(self)
      return vim.api.nvim_buf_get_option(self.bufnr, 'modified')
    end,
    provider = ' ● ', --"[+]",
    hl = { fg = 'green' },
  },
  {
    condition = function(self)
      return not vim.api.nvim_buf_get_option(self.bufnr, 'modifiable')
        or vim.api.nvim_buf_get_option(self.bufnr, 'readonly')
    end,
    provider = function(self)
      if vim.api.nvim_buf_get_option(self.bufnr, 'buftype') == 'terminal' then
        return '  '
      else
        return ''
      end
    end,
    hl = { fg = 'orange' },
  },
  {
    condition = function(self)
      return not vim.api.nvim_buf_is_loaded(self.bufnr)
    end,
    -- a downright arrow
    provider = ' 󰘓 ', --󰕁 
    hl = { fg = 'gray' },
  },
}
