require('ccc').setup {
  highlighter = {
    auto_enable = true,
    lsp = true,
  },
}

local gid = vim.augroup.GetOrAdd 'CccRc'
vim.autocmd.create('BufWinEnter', {
  group = gid,
  callback = function()
    vim.cmd.CccHighlighterEnable()
  end,
})

vim.api.nvim_create_user_command('CccDisableAutoHighlight', function()
  vim.augroup.delete(gid)
end, {})
