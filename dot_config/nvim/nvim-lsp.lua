vim.api.nvim_create_autocmd('LspAttach', {
  group = 'VimRc',
  desc = 'nvim-lsp 用のキーマッピングなどを設定する',
  callback = function(context)
    require('rc.nvim-lsp').set_keymaps(context)
  end,
})

-- vim.lspの読み込みが発生して起動が遅くなるのでLspAttachまで遅延する
vim.api.nvim_create_autocmd('LspAttach', {
  group = 'VimRc',
  once = true,
  desc = 'nvim-lspのhoverやdiagnosticの設定をする',
  callback = function()
    require('rc.nvim-lsp').setup()
  end,
})

-- vim.lspの読み込みは発生しないのと、
-- これが定義されてる前提のスクリプト(heirlineのコンポーネントとか)が
-- エラーになるのですぐに実行する
vim.fn.sign_define {
  {
    name = 'DiagnosticSignError',
    text = ' ',
    texthl = 'DiagnosticSignError',
  },
  {
    name = 'DiagnosticSignWarn',
    text = ' ',
    texthl = 'DiagnosticSignWarn',
  },
  {
    name = 'DiagnosticSignInfo',
    text = ' ',
    texthl = 'DiagnosticSignInfo',
  },
  {
    name = 'DiagnosticSignHint',
    text = ' ',
    texthl = 'DiagnosticSignHint',
  },
}
