-- lua_source {{{

-- masonでインストールを管理してないLSの設定など

if vim.env.NO_LSP then
  return
end

local lspconfig = require 'lspconfig'

local function get_completion_capabilities()
  local dein = require 'dein'
  if not dein.is_sourced 'cmp-nvim-lsp' then
    dein.source 'cmp-nvim-lsp'
  end
  return require('cmp_nvim_lsp').default_capabilities().textDocument.completion
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion = get_completion_capabilities()

if 1 == vim.fn.executable 'haskell-language-server-wrapper' then
  lspconfig.hls.setup {
    capabilities = capabilities,
    filetypes = { 'haskell' },
  }
end

if 1 == vim.fn.executable 'deno' then
  vim.g.markdown_fenced_languages = {
    'ts=typescript',
  }
  lspconfig.denols.setup {
    capabilities = capabilities,
    root_dir = function(startpath)
      local node_modules = vim.fs.find({ 'node_modules', 'tsconfig.json', 'jsconfig.json' }, {
        path = startpath,
        upward = true,
        type = 'directory',
      })
      if #node_modules > 0 then
        return
      end
      local root = vim.fs.find({ '.git', 'deno.json', 'package.json' }, {
        path = startpath,
        upward = true,
      })
      if #root == 0 then
        return vim.fs.dirname(startpath)
      end
      return vim.fs.dirname(root[1])
    end,
    init_options = {
      unstable = true,
    },
  }
end
-- }}}
