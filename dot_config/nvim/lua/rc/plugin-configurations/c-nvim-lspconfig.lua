local lspconfig = require 'lspconfig'

lspconfig.hls.setup {
  filetypes = { 'haskell' },
}

lspconfig.denols.setup {
  root_dir = require('lspconfig.util').root_pattern { 'deno.json', 'deno.jsonc', 'denops', 'tsnip' },
  init_options = {
    unstable = true,
  },
}
