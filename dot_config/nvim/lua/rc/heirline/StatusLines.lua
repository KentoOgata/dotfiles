local conditions = require 'heirline.conditions'

local viMode = require 'rc.heirline.components.ViMode'
local spell = require 'rc.heirline.components.Spell'
local workDir = require 'rc.heirline.components.WorkDir'
local fileNameBlock = require 'rc.heirline.components.FileNameBlock'
local git = require 'rc.heirline.components.Git'
local diagnostics = require 'rc.heirline.components.Diagnostics'
local lspActive = require 'rc.heirline.components.LspActive'
local fileType = require 'rc.heirline.components.FileType'
local fileIcon = require 'rc.heirline.components.FileIcon'
local fileEncoding = require 'rc.heirline.components.FileEncoding'
local ruler = require 'rc.heirline.components.Ruler'
local searchCount = require 'rc.heirline.components.SearchCount'

local space = { provider = ' ' }
local align = { provider = '%=' }

local defaultStatusLine = {
  spell,
  workDir,
  { provider = '%<' },
  space,
  git,
  space,
  diagnostics,
  align,
  lspActive,
  space,
  fileType,
  space,
  fileIcon,
  { flexible = 3, { fileEncoding, space }, { provider = '' } },
  space,
  ruler,
  searchCount,
}

local inactiveStatusLine = {
  condition = conditions.is_not_active,
  { hl = { fg = 'gray', force = true }, workDir },
  fileNameBlock,
  { provider = '%<' },
  align,
}

local helpFileName = require 'rc.heirline.components.HelpFileName'

local specialStatusLine = {
  condition = function()
    return conditions.buffer_matches {
      buftype = { 'nofile', 'prompt', 'help', 'quickfix' },
      filetype = { '^git.*', 'fugitive' },
    }
  end,
  fileType,
  { provider = '%q' },
  space,
  helpFileName,
  align,
}

local terminalName = require 'rc.heirline.components.TerminalName'

local terminalStatusLine = {
  condition = function()
    return conditions.buffer_matches { buftype = { 'terminal' } }
  end,
  hl = { bg = 'dark_red' },
  { condition = conditions.is_active, viMode, space },
  fileType,
  space,
  terminalName,
  align,
}

return {
  hl = function()
    if conditions.is_active() then
      return 'StatusLine'
    else
      return 'StatusLineNC'
    end
  end,
  static = {
    mode_colors = {
      n = 'orange',
      i = 'green',
      v = 'cyan',
      V = 'cyan',
      ['\22'] = 'cyan', -- this is an actual ^V, type <C-v><C-v> in insert mode
      c = 'orange',
      s = 'purple',
      S = 'purple',
      ['\19'] = 'purple', -- this is an actual ^S, type <C-v><C-s> in insert mode
      R = 'blue',
      r = 'blue',
      ['!'] = 'red',
      t = 'green',
    },
    mode_color = function(self)
      local mode = conditions.is_active() and vim.fn.mode() or 'n'
      return self.mode_colors[mode]
    end,
  },
  fallthrough = false,
  -- GitStatusline,
  specialStatusLine,
  terminalStatusLine,
  inactiveStatusLine,
  defaultStatusLine,
}
