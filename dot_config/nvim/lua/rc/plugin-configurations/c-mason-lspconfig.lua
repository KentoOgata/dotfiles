require('mason-lspconfig').setup {
  ensure_installed = {
    'lua_ls',
    'omnisharp',
    'dockerls',
    'yamlls',
    'jsonls',
    'tsserver',
    'eslint',
    'rust_analyzer',
  },
}
