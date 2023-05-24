local fileName = require 'rc.heirline.components.FileName'
local fileFlags = require 'rc.heirline.components.FileFlags'

return {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  fileName,
  unpack(fileFlags),
}
