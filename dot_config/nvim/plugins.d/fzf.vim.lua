-- lua_source {{{
vim.api.nvim_create_user_command('GhqFind', function()
  vim.fn['fzf#run'] {
    source = vim.fn.systemlist { 'ghq', 'list', '--full-path' },
    sink = function(path)
      require('fzf-lua').files {
        cwd = path,
      }
    end,
    window = {
      width = 0.9,
      height = 0.6,
    },
  }
end, {})
-- }}}
