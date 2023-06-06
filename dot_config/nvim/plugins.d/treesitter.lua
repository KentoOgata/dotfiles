-- lua_source {{{
local parser_dir = ('%s/treesitter'):format(vim.fn.stdpath 'data')
vim.opt.runtimepath:append(parser_dir)

-- Add ex parsers
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.xml = {
  install_info = {
    url = 'https://github.com/dorgnarg/tree-sitter-xml.git',
    files = { 'src/parser.c' },
    branch = 'main',
    generate_requires_npm = false,
    requires_generate_from_grammar = true,
  },
  filetype = 'xml',
}

parser_config.unifieddiff = {
  install_info = {
    url = 'https://github.com/monaqa/tree-sitter-unifieddiff.git',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  -- NOTE: パーサー名とファイルタイプ名が一致しないときは指定する必要がある
  filetype = 'diff',
}

-- parser_config.ps1 = {
--   install_info = {
--     url = 'https://github.com/PowerShell/tree-sitter-PowerShell',
--     files = { 'src/scanner.c' },
--     branch = 'master',
--     generate_requires_npm = true,
--     requires_generate_from_grammar = true,
--   },
--   filetype = 'ps1',
-- }

require('nvim-treesitter.configs').setup {
  ensure_installed = {},
  auto_install = true,
  parser_install_dir = parser_dir,
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {
      'yaml',
    },
  },
}
-- }}}
