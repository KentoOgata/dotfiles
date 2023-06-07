-- lua_source {{{
vim.api.nvim_create_user_command('FzfPlugins', function()
  vim.fn['fzf#run'] {
    source = vim.fn.map(vim.fn.values(vim.fn['dein#get']()), function(_, plugin)
      return plugin.name
    end),
    sink = function(name)
      require('fzf-lua').files {
        cwd = vim.fn['dein#get'](name).path,
      }
    end,
    window = {
      width = 0.9,
      height = 0.6,
    },
  }
end, {})
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
