local tabLineOffset = require 'rc.heirline.components.TabLineOffset'
local bufferLine = require 'rc.heirline.components.BufferLine'
local tabPages = require 'rc.heirline.components.TabPages'
local gitBranch = require 'rc.heirline.components.GitBranch'

local utils = require 'heirline.utils'

return {
  tabLineOffset,
  utils.surround({ ' ', ' ' }, function()
    return utils.get_highlight('TabLine').bg
  end, gitBranch),
  bufferLine,
  tabPages,
}
