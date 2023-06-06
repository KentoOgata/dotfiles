return {
  provider = function(self)
    self.bufnr = self.bufnr or vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(self.bufnr)
    local extension = vim.fn.fnamemodify(filename, ':e')
    local icon, icon_color = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
    self.icon_color = icon_color
    return icon and (icon .. ' ')
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}
