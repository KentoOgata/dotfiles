if vim.fn['dein#tap'] 'noice.nvim' ~= 0 then
  require('telescope').load_extension 'noice'
end

local telescope_actions = require 'telescope.builtin'
vim.keymap.set('n', '<Plug>(telescope-current_buffer)', telescope_actions.current_buffer_fuzzy_find)
vim.keymap.set('n', '<Plug>(telescope-help_tags)', telescope_actions.help_tags)
vim.keymap.set('n', '<Plug>(telescope-git)', telescope_actions.git_status)
vim.keymap.set('n', '<Plug>(telescope-lsp_symbols)', telescope_actions.lsp_dynamic_workspace_symbols)
vim.keymap.set('n', '<Plug>(telescope-lsp_references)', telescope_actions.lsp_references)
vim.keymap.set('n', '<Plug>(telescope-lsp_implementations)', telescope_actions.lsp_implementations)
vim.keymap.set('n', '<Plug>(telescope-resume)', telescope_actions.resume)
vim.keymap.set('n', '<Plug>(telescope-command_history)', telescope_actions.command_history)
vim.keymap.set('n', '<Plug>(telescope-file)', function()
  vim.fn.system 'git rev-parse'
  if vim.v.shell_error == 0 then
    telescope_actions.git_files()
  else
    telescope_actions.find_files()
  end
end)
vim.keymap.set('n', '<Plug>(telescope-grep)', function()
  telescope_actions.grep_string {
    search = vim.fn.input { prompt = 'Grep: ' },
  }
end)
vim.keymap.set('n', '<Plug>(telescope-buffer)', function()
  telescope_actions.buffers {
    ignore_current_buffer = true,
    sort_mru = true,
  }
end)
vim.keymap.set('n', '<Plug>(telescope-vimrc)', function()
  telescope_actions.find_files {
    cwd = vim.env['DOTFILES'],
  }
end)
