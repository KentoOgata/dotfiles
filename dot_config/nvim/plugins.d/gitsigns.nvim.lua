-- lua_source {{{
local gitsigns = require 'gitsigns'
gitsigns.setup {
  signs = {
    add = { text = '+' },
    change = { text = '|' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
  on_attach = function(bufnr)
    vim.keymap.set_table {
      mode = 'n',
      opts = {
        buffer = bufnr,
        silent = true,
      },
      maps = {
        -- Navigation
        {
          ']c',
          function()
            if vim.wo.diff then
              vim.cmd.normal { args = { ']c' }, bang = true }
              return
            end

            require('gitsigns').next_hunk {
              navigation_message = false,
            }
          end,
        },
        {
          '[c',
          function()
            if vim.wo.diff then
              vim.cmd.normal { args = { '[c' }, bang = true }
              return
            end

            require('gitsigns').prev_hunk {
              navigation_message = false,
            }
          end,
        },
        -- Actions
        { '<Space>hs', '<cmd>Gitsigns stage_hunk<CR>' },
        { '<Space>hS', '<cmd>Gitsigns undo_stage_hunk<CR>' },
        { '<Space>hu', '<cmd>Gitsigns reset_hunk<CR>' },
        { '<Space>hp', '<cmd>Gitsigns preview_hunk<CR>' },
        { '<Space>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>' },
        { '<Space>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>' },
        { '<Space>hd', '<cmd>Gitsigns diffthis<CR>' },
        { '<Space>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>' },
        { '<Space>td', '<cmd>Gitsigns toggle_deleted<CR>' },
      },
    }

    -- Text object
    vim.keymap.set({ 'x', 'o' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
}
-- }}}
