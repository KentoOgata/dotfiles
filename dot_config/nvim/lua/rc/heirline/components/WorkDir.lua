local conditions = require 'heirline.conditions'

return {
  init = function(self)
    self.icon = '  '
    local cwd = vim.fn.getcwd(0)
    self.cwd = vim.fn.fnamemodify(cwd, ':~')
    if not conditions.width_percent_below(#self.cwd, 0.27) then
      self.cwd = vim.fn.pathshorten(self.cwd)
    end
  end,
  hl = { fg = 'blue', bold = true },
  on_click = {
    callback = function(self)
      vim.cmd(('Fern %s -drawer -toggle'):format(self.cwd))
    end,
    name = 'heirline_workdir',
  },
  flexible = 1,
  {
    provider = function(self)
      local trail = self.cwd:sub(-1) == '/' and '' or '/'
      return self.icon .. self.cwd .. trail .. ' '
    end,
  },
  {
    provider = function(self)
      local cwd = vim.fn.pathshorten(self.cwd)
      local trail = self.cwd:sub(-1) == '/' and '' or '/'
      return self.icon .. cwd .. trail .. ' '
    end,
  },
  {
    provider = '',
  },
}
