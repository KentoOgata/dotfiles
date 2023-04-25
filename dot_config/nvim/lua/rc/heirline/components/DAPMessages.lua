return {
  condition = function()
    local available, dap = pcall(require, 'dap')
    return available and dap.session() ~= nil
  end,
  provider = function()
    local available, dap = pcall(require, 'dap')
    if available then
      return ' ' .. dap.status() .. ' '
    else
      return ''
    end
  end,
  hl = 'Debug',
  {
    provider = ' ',
    on_click = {
      callback = function()
        local available, dap = pcall(require, 'dap')
        if available then
          dap.step_into()
        end
      end,
      name = 'heirline_dap_step_into',
    },
  },
  { provider = ' ' },
  {
    provider = ' ',
    on_click = {
      callback = function()
        local ok, dap = pcall(require, 'dap')
        if ok then
          dap.step_out()
        end
      end,
      name = 'heirline_dap_step_out',
    },
  },
  { provider = ' ' },
  {
    provider = ' ',
    on_click = {
      callback = function()
        local ok, dap = pcall(require, 'dap')
        if ok then
          dap.step_over()
        end
      end,
      name = 'heirline_dap_step_over',
    },
  },
  { provider = ' ' },
  {
    provider = ' ',
    hl = { fg = 'green' },
    on_click = {
      callback = function()
        local ok, dap = pcall(require, 'dap')
        if ok then
          dap.run_last()
        end
      end,
      name = 'heirline_dap_run_last',
    },
  },
  { provider = ' ' },
  {
    provider = ' ',
    hl = { fg = 'red' },
    on_click = {
      callback = function()
        local dapAvailable, dap = pcall(require, 'dap')
        if dapAvailable then
          dap.terminate()
        end
        local dapuiAvailable, dapui = pcall(require, 'dapui')
        if dapuiAvailable then
          dapui.close {}
        end
      end,
      name = 'heirline_dap_close',
    },
  },
  { provider = ' ' },
  --       ﰇ  
}
