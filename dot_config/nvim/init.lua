-- gf    : Open cursor holding file.
-- <C-o> : Jump to previous point.
-- <C-i> : Jump to next point.
-- K     : Search help docs with cursor text.

vim.loader.enable()
require 'rc.global'
vim.g.mapleader = ' '
vim.keymap.set('n', '<Leader>', '<Nop>')
require 'rc.env'
require('rc.keymaps').setup()
require('rc.options').setup()
require('rc.lsp').setup()
require('rc.filetype').setup()
require('rc.terminal').setup 'fish'
require('rc.default-plugins').use {
  'rplugin',
  'man',
  'shada',
}
-- AutoCommandで機能する系のプラグインはdein-options-ifを使って切り替えているので
-- pluginを登録するよりも先に設定しなければならない
vim.g.AutoCompletionEngine = 'nvim-cmp'
require 'rc.plugins'
if vim.bool_fn.executable 'fzf' then
  vim.cmd.MapFzfLua()
else
  vim.cmd.MapTelescope()
end
vim.cmd.RandomTheme()
vim.cmd.highlight { 'link', '@text.diff.add', 'diffAdded' }
vim.cmd.highlight { 'link', '@text.diff.delete', 'diffRemoved' }
vim.autocmd.create('OptionSet', {
  pattern = 'undolevels',
  callback = function(ctx)
    vim.notify('undolevels: ' .. vim.bo[ctx.buf].undolevels)
  end,
})
