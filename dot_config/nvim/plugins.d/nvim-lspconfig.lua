-- lua_source {{{
local lspconfig = require 'lspconfig'

if 1 == vim.fn.executable 'haskell-language-server-wrapper' then
  lspconfig.hls.setup {
    filetypes = { 'haskell' },
  }
end

if 1 == vim.fn.executable 'deno' then
  lspconfig.denols.setup {
    root_dir = require('lspconfig.util').root_pattern { 'deno.json', 'deno.jsonc', 'denops', 'tsnip' },
    init_options = {
      unstable = true,
    },
  }
end

if 1 == vim.fn.executable 'lua-language-server' then
  lspconfig.lua_ls.setup {
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
  lspconfig.gopls.setup {}
end

if 1 == vim.fn.executable 'rust-analyzer' then
  lspconfig.rust_analyzer.setup {
    settings = {
      ['rust-analyzer'] = {
        enable = true,
      },
    },
  }
end

if 1 == vim.fn.executable 'clangd' then
  lspconfig.clangd.setup {}
end

if 1 == vim.fn.executable 'omnisharp' then
  lspconfig.omnisharp.setup {
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

      -- OmniSharpはInitializeが終わらないとレスポンスを返さないので
      -- キーマップが有効になるタイミングとかわからないとつらい
      -- capabilitiesを渡す設定がbufferにカーソルがないと上手く動かないっぽいのもつらい
      if not vim.g.OmniSharpStarted then
        vim.cmd.highlight { 'link', '@lsp.type.tag.cs', '@tag' }
        vim.cmd.highlight { 'link', '@lsp.type.tag.attribute', '@tag.attribute' }
        vim.cmd.highlight { 'link', '@lsp.type.tag.delimiter.cs', '@tag.delimiter' }
        vim.cmd.highlight { 'link', '@lsp.type.tag.text.cs', '@text' }

        vim.notify('OmniSharp is active now.', vim.log.levels.INFO)
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
    settings = {
      yaml = {
        keyOrdering = false,
      },
    },
  }
end
-- }}}
