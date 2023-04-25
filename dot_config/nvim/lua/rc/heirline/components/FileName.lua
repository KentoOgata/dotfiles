local conditions = require 'heirline.conditions'
local utils = require 'heirline.utils'

return {
  init = function(self)
    self.lfilename = vim.fn.fnamemodify(self.filename, ':.')
    if self.lfilename == '' then
      self.lfilename = '[No Name]'
    end
    if not conditions.width_percent_below(#self.lfilename, 0.27) then
      self.lfilename = vim.fn.pathshorten(self.lfilename)
    end
  end,
  hl = function()
    if vim.bo.modified then
      return { fg = utils.get_highlight('Directory').fg, bold = true, italic = true }
    end
    return 'Directory'
  end,
  flexible = 2,
  {
    provider = function(self)
      return self.lfilename
    end,
  },
  {
    provider = function(self)
      return vim.fn.pathshorten(self.lfilename)
    end,
  },
}
