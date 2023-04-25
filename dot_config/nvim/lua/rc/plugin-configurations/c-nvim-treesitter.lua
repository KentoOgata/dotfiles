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
    disable = {
      'vim',
    },
  },
  indent = {
    enable = true,
    disable = {
      'yaml',
    },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ['at'] = '@tag.outer',
        ['it'] = '@tag.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
      },
    },
  },
}
