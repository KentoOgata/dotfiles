-- lua_source {{{

-- masonでインストールを管理してるLSの設定はここに書く

if vim.env.NO_LSP then
  return
end

require('mason-lspconfig').setup {}

local function get_completion_capabilities()
  local dein = require 'dein'
  if not dein.is_sourced 'cmp-nvim-lsp' then
    dein.source 'cmp-nvim-lsp'
  end
  return require('cmp_nvim_lsp').default_capabilities().textDocument.completion
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion = get_completion_capabilities()

local format_disabled_capabilities = vim.deepcopy(capabilities)
format_disabled_capabilities.textDocument.formatting = nil
format_disabled_capabilities.textDocument.rangeFormatting = nil
format_disabled_capabilities.textDocument.onTypeFormatting = nil

local lspconfig = require 'lspconfig'

require('mason-lspconfig').setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {
      capabilities = capabilities,
    }
  end,
  ['omnisharp'] = function()
    lspconfig.omnisharp.setup {
      cmd = { 'omnisharp' },
      capabilities = format_disabled_capabilities,
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
  end,
  ['vtsls'] = function()
    lspconfig.vtsls.setup {
      capabilities = capabilities,
      root_dir = require('lspconfig.util').root_pattern { 'tsconfig.json', 'jsconfig.json', 'package.json' },
      single_file_support = false,
    }
  end,
  ['lua_ls'] = function()
    lspconfig.lua_ls.setup {
      capabilities = format_disabled_capabilities,
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
  end,
  ['rust_analyzer'] = function()
    lspconfig.rust_analyzer.setup {
      capabilities = capabilities,
      settings = {
        ['rust-analyzer'] = {
          enable = true,
        },
      },
    }
  end,
  ['yamlls'] = function()
    lspconfig.yamlls.setup {
      capabilities = capabilities,
      settings = {
        yaml = {
          keyOrdering = false,
        },
      },
    }
  end,
}
-- }}}
