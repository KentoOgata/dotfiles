local utils = require 'heirline.utils'

return {
  condition = function()
    return vim.fn.reg_recording() ~= '' and vim.o.cmdheight == 0
  end,
  provider = '壘',
  hl = { fg = 'orange', bold = true },
  utils.surround({ '[', ']' }, nil, {
    provider = function()
      return vim.fn.reg_recording()
    end,
    hl = { fg = 'green', bold = true },
  }),
  update = {
    'RecordingEnter',
    'RecordingLeave',
    callback = vim.schedule_wrap(function()
      vim.cmd 'redrawstatus'
    end),
  },
  { provider = ' ' },
}
