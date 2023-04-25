local fileIcon = require 'rc.heirline.components.FileIcon'
local fileName = require 'rc.heirline.components.FileName'
local fileFlags = require 'rc.heirline.components.FileFlags'

return {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  fileIcon,
  fileName,
  unpack(fileFlags),
}
