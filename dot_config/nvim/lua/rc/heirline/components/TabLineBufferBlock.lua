local utils = require 'heirline.utils'

local tabLinePicker = require 'rc.heirline.components.TabLinePicker'
local tabLineFileNameBlock = require 'rc.heirline.components.TabLineFileNameBlock'
local tabLineCloseButton = require 'rc.heirline.components.TabLineCloseButton'

return utils.surround({ '', '' }, function(self)
  if self.is_active then
    return utils.get_highlight('TabLineSel').bg
  else
    return utils.get_highlight('TabLine').bg
  end
end, {
  init = function()
    vim.keymap.set('n', 'gb', function()
      local tabline = require('heirline').tabline
      local buflist = tabline._buflist[1]
      buflist._picker_labels = {}
      buflist._show_picker = true
      vim.cmd.redrawtabline()
      local char = vim.fn.getcharstr()
      local bufnr = buflist._picker_labels[char]
      if bufnr then
        vim.api.nvim_win_set_buf(0, bufnr)
      end
      buflist._show_picker = false
      vim.cmd.redrawtabline()
    end)
  end,
  tabLinePicker,
  tabLineFileNameBlock,
  tabLineCloseButton,
})
