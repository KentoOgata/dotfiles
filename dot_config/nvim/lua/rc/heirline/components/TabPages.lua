local utils = require 'heirline.utils'

local tabPage = require 'rc.heirline.components.TabPage'
local tabPageClose = require 'rc.heirline.components.TabPageClose'

return {
  condition = function()
    return #vim.api.nvim_list_tabpages() >= 2
  end,
  {
    provider = '%=',
  },
  utils.make_tablist(tabPage),
  tabPageClose,
}
