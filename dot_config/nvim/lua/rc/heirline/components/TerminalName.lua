return {
  -- icon = ' ', -- 
  {
    provider = function()
      local tname, _ = vim.api.nvim_buf_get_name(0):gsub('.*:', '')
      return ' ' .. tname
    end,
    hl = { fg = 'blue', bold = true },
  },
  { provider = ' - ' },
  {
    provider = function()
      return vim.b[vim.api.nvim_get_current_buf()].term_title or ''
    end,
  },
  {
    provider = function()
      local ok, terminal = pcall(require, 'terminal')
      if ok then
        local id = terminal:current_term_index()
        return ' ' .. (id or 'Exited')
      else
        return ''
      end
    end,
    hl = { bold = true, fg = 'blue' },
  },
}
