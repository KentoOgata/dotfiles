-- lua_source {{{
require('dressing').setup {
  input = {
    enabled = true,
    default_prompt = 'Input:',
    prompt_align = 'left',
    insert_only = true,
    start_in_insert = true,
    anchor = 'SW',
    border = 'single',
    relative = 'cursor',
    prefer_width = 40,
    width = nil,
    max_width = { 140, 0.9 },
    min_width = { 20, 0.2 },
    buf_options = {},
    win_options = {
      winblend = 10,
      wrap = false,
    },
    mappings = {
      n = {
        ['q'] = 'Close',
        ['<Esc>'] = 'Close',
        ['<CR>'] = 'Confirm',
      },
      i = {
        ['<C-c>'] = 'Close',
        ['<CR>'] = 'Confirm',
        ['<C-p>'] = 'HistoryPrev',
        ['<C-n>'] = 'HistoryNext',
      },
    },
  },
  select = {
    enabled = true,
    backend = { 'fzf_lua', 'telescope', 'nui', 'builtin' },
    trim_prompt = true,
    telescope = nil,
    builtin = {
      anchor = 'NW',
      border = 'single',
      relative = 'editor',
      buf_options = {},
      win_options = {
        winblend = 10,
      },
      width = nil,
      max_width = { 140, 0.8 },
      min_width = { 40, 0.2 },
      height = nil,
      max_height = 0.9,
      min_height = { 10, 0.2 },
      mappings = {
        ['<Esc>'] = 'Close',
        ['<C-c>'] = 'Close',
        ['<CR>'] = 'Confirm',
      },
    },
  },
}
-- }}}
