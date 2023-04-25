return setmetatable({}, {
  __index = {
    ---@param shell string
    setup = function(shell)
      vim.api.nvim_create_user_command('Shell', 'e term://%:h//' .. shell, {})
      vim.api.nvim_create_user_command('HShell', 'bel sp term://%:h//' .. shell, {})
      vim.api.nvim_create_user_command('VShell', 'bel vs term://%:h//' .. shell, {})
    end,
  },
})
