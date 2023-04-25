return {
  provider = function(self)
    local filename = self.filename
    filename = filename == '' and '[No Name]' or vim.fn.fnamemodify(filename, ':t')
    return filename
  end,
  hl = function(self)
    return { bold = self.is_active or self.is_visible, italic = true }
  end,
}
