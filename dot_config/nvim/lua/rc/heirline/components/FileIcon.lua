return {
  provider = function(self)
    local filename = vim.api.nvim_buf_get_name(0)
    local extension = vim.fn.fnamemodify(filename, ':e')
    local icon, icon_color = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
    self.icon_color = icon_color
    return icon and (icon .. ' ')
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}
