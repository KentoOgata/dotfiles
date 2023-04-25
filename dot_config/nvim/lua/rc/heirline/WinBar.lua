local conditions = require 'heirline.conditions'
local utils = require 'heirline.utils'

local fileType = require 'rc.heirline.components.FileType'
local terminalName = require 'rc.heirline.components.TerminalName'
local closeButton = require 'rc.heirline.components.CloseButton'
local fileNameBlock = require 'rc.heirline.components.FileNameBlock'
local navic = require 'rc.heirline.components.Navic'

local space = { provider = ' ' }
local align = { provider = '%=' }

return {
  fallthrough = false,
  -- {
  --     condition = function()
  --         return conditions.buffer_matches({
  --             buftype = { "nofile", "prompt", "help", "quickfix" },
  --             filetype = { "^git.*", "fugitive" },
  --         })
  --     end,
  --     init = function()
  --         vim.opt_local.winbar = nil
  --     end,
  -- },
  {
    condition = function()
      return conditions.buffer_matches { buftype = { 'terminal' } }
    end,
    utils.surround({ '', '' }, 'dark_red', {
      fileType,
      space,
      terminalName,
      closeButton,
    }),
  },
  utils.surround({ '', '' }, 'bright_bg', {
    fallthrough = false,
    {
      condition = conditions.is_not_active,
      {
        hl = { fg = 'bright_fg', force = true },
        align,
        fileNameBlock,
      },
      closeButton,
    },
    {
      -- provider = "      ",
      navic,
      { provider = '%<' },
      align,
      fileNameBlock,
      closeButton,
    },
  }),
}
