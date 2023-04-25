return {
  condition = function(self)
    return self._show_picker
  end,
  init = function(self)
    local bufname = vim.api.nvim_buf_get_name(self.bufnr)
    bufname = vim.fn.fnamemodify(bufname, ':t')
    local label = bufname:sub(1, 1)
    local i = 2
    while self._picker_labels[label] do
      label = bufname:sub(i, i)
      if i > #bufname then
        break
      end
      i = i + 1
    end
    self._picker_labels[label] = self.bufnr
    self.label = label
  end,
  provider = function(self)
    return self.label
  end,
  hl = { fg = 'red', bold = true },
}
