-- lua_source {{{
local lspconfig = require 'lspconfig'

local function ensure_capabilities()
  local dein = require 'dein'
  if not dein.is_sourced 'cmp-nvim-lsp' then
    dein.source 'cmp-nvim-lsp'
  end
  return require('cmp_nvim_lsp').default_capabilities()
end
local capabilities = ensure_capabilities()
local formatDisabled = vim.tbl_deep_extend('force', capabilities, {
  textDocument = {
    formatting = nil,
    rangeFormatting = nil,
    onTypeFormatting = nil,
  },
})

if 1 == vim.fn.executable 'vscode-json-language-server' then
  lspconfig.jsonls.setup {
    capabilities = capabilities,
  }
end

if 1 == vim.fn.executable 'haskell-language-server-wrapper' then
  lspconfig.hls.setup {
    capabilities = capabilities,
    filetypes = { 'haskell' },
  }
end

if 1 == vim.fn.executable 'deno' then
  lspconfig.denols.setup {
    capabilities = capabilities,
    root_dir = require('lspconfig.util').root_pattern {
      'deno.json',
      'deno.jsonc',
      'denops',
      'tsnip',
      'deps.ts',
    },
    init_options = {
      unstable = true,
    },
  }
end

if 1 == vim.fn.executable 'lua-language-server' then
  lspconfig.lua_ls.setup {
    capabilities = formatDisabled,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file('', true),
        },
        telemetry = {
          enable = false,
        },
        completion = {
          autoRequire = false,
        },
        format = {
          enable = vim.bool_fn.executable 'stylua',
        },
      },
    },
  }
end

if 1 == vim.fn.executable 'gopls' then
  lspconfig.gopls.setup {
    capabilities = capabilities,
  }
end

if 1 == vim.fn.executable 'rust-analyzer' then
  lspconfig.rust_analyzer.setup {
    capabilities = capabilities,
    settings = {
      ['rust-analyzer'] = {
        enable = true,
      },
    },
  }
end

if 1 == vim.fn.executable 'clangd' then
  lspconfig.clangd.setup {
    capabilities = capabilities,
  }
end

if 1 == vim.fn.executable 'omnisharp' then
  lspconfig.omnisharp.setup {
    cmd = { 'omnisharp' },
    capabilities = formatDisabled,
    on_attach = function(client)
      -- OmniSharp's semantic token format is broken.
      -- https://github.com/OmniSharp/omnisharp-roslyn/issues/2483
      client.server_capabilities.semanticTokensProvider = {
        full = vim.empty_dict(),
        legend = {
          tokenModifiers = { 'static_symbol' },
          tokenTypes = {
            'comment',
            'excluded.code',
            'identifier',
            'keyword',
            'keyword.control',
            'number',
            'operator',
            'operator.overloaded',
            'preproc',
            'string',
            'whitespace',
            'text',
            'static.symbol',
            'preprocessor.text',
            'punctuation',
            'string.verbatim',
            'string.escape',
            'class',
            'delegate.name',
            'enum',
            'interface',
            'module.name',
            'struct',
            'typeParameter',
            'field',
            'enumMember',
            'constant.name',
            'variable',
            'parameter',
            'method',
            'extension.method.name',
            'property',
            'event',
            'namespace',
            'label',
            'tag.attribute',
            'xml.doc.comment.attribute.quotes',
            'xml.doc.comment.attribute.value',
            'xml.doc.comment.cdata.section',
            'comment',
            'tag.delimiter',
            'xml.doc.comment.entity.reference',
            'tag',
            'xml.doc.comment.processing.instruction',
            'tag.text',
            'xml.literal.attribute.name',
            'xml.literal.attribute.quotes',
            'xml.literal.attribute.value',
            'xml.literal.cdata.section',
            'xml.literal.comment',
            'xml.literal.delimiter',
            'xml.literal.embedded.expression',
            'xml.literal.entity.reference',
            'xml.literal.name',
            'xml.literal.processing.instruction',
            'xml.literal.text',
            'regex.comment',
            'regex.character.class',
            'regex.anchor',
            'regex.quantifier',
            'regex.grouping',
            'regex.alternation',
            'regex.text',
            'regex.self.escaped.character',
            'regex.other.escape',
          },
        },
        range = true,
      }

      if not vim.g.OmniSharpStarted then
        vim.cmd.highlight { 'link', '@lsp.type.tag.cs', '@tag' }
        vim.cmd.highlight { 'link', '@lsp.type.tag.attribute', '@tag.attribute' }
        vim.cmd.highlight { 'link', '@lsp.type.tag.delimiter.cs', '@tag.delimiter' }
        vim.cmd.highlight { 'link', '@lsp.type.tag.text.cs', '@text' }
        vim.g.OmniSharpStarted = true
      end
    end,
    enable_editorconfig_support = true,
    enable_roslyn_analyzers = false,
    organize_imports_on_format = false,
    enable_import_completion = false,
  }
end

if 1 == vim.fn.executable 'typescript-language-server' then
  lspconfig.tsserver.setup {
    capabilities = formatDisabled,
    root_dir = require('lspconfig.util').root_pattern { 'tsconfig.json', 'jsconfig.json', 'package.json' },
    single_file_support = false,
  }
end

-- if 1 == vim.fn.executable 'csharp-ls' then
--   require('lspconfig').csharp_ls.setup {
--     -- slnだけに指定しないと近くのcsprojにマッチして
--     -- プロジェクト全体を対象にしたdefinition jumpとかができなくなる
--     root_dir = require('lspconfig.util').root_pattern { '*.sln' },
--   }
-- end

if 1 == vim.fn.executable 'yaml-language-server' then
  lspconfig.yamlls.setup {
    capabilities = capabilities,
    settings = {
      yaml = {
        keyOrdering = false,
      },
    },
  }
end

if 1 == vim.fn.executable 'vscode-css-language-server' then
  lspconfig.cssls.setup {
    capabilities = capabilities,
  }
end
-- }}}
