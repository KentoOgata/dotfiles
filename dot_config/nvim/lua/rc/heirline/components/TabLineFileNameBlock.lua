local tabLineBufnr = require 'rc.heirline.components.TabLineBufnr'
local fileIcon = require 'rc.heirline.components.FileIcon'
local tabLineFileName = require 'rc.heirline.components.TabLineFileName'
local tabLineFileFlags = require 'rc.heirline.components.TabLineFileFlags'

return {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(self.bufnr)
  end,
  hl = function(self)
    if self.is_active then
      return 'TabLineSel'
    elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
      return { fg = 'gray' }
    else
      return 'TabLine'
    end
  end,
  on_click = {
    callback = function(_, minwid)
      vim.api.nvim_win_set_buf(0, minwid)
    end,
    minwid = function(self)
      return self.bufnr
    end,
    name = 'heirline_tabline_buffer_callback',
  },
  tabLineBufnr,
  fileIcon,
  tabLineFileName,
  tabLineFileFlags,
}
