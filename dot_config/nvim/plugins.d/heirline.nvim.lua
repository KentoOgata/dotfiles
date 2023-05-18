-- lua_source {{{
vim.go.laststatus = 2
vim.go.showtabline = 2
local utils = require 'heirline.utils'

local separators = {
  rounded_left = '',
  rounded_right = '',
  rounded_left_hollow = '',
  rounded_right_hollow = '',
  powerline_left = '',
  powerline_right = '',
  powerline_right_hollow = '',
  powerline_left_hollow = '',
  slant_left = '',
  slant_right = '',
  inverted_slant_left = '',
  inverted_slant_right = '',
  slant_ur = '',
  slant_br = '',
  vert = '│',
  vert_thick = '┃',
  block = '█',
  double_vert = '║',
  dotted_vert = '┊',
}

local function setup_colors()
  vim.g.heirline_colors = {
    bright_bg = utils.get_highlight('Folded').bg or 0,
    bright_fg = utils.get_highlight('Folded').fg or 0,
    red = utils.get_highlight('DiagnosticError').fg or 0,
    dark_red = utils.get_highlight('DiffDelete').bg or 0,
    green = utils.get_highlight('String').fg or 0,
    blue = utils.get_highlight('Function').fg or 0,
    gray = utils.get_highlight('NonText').fg or 0,
    orange = utils.get_highlight('Constant').fg or 0,
    purple = utils.get_highlight('Statement').fg or 0,
    cyan = utils.get_highlight('Special').fg or 0,
    diag_warn = utils.get_highlight('DiagnosticWarn').fg or 0,
    diag_error = utils.get_highlight('DiagnosticError').fg or 0,
    diag_hint = utils.get_highlight('DiagnosticHint').fg or 0,
    diag_info = utils.get_highlight('DiagnosticInfo').fg or 0,
    git_del = utils.get_highlight('diffRemoved').fg or 0,
    git_add = utils.get_highlight('diffAdded').fg or 0,
    git_change = utils.get_highlight('diffChanged').fg or 0,
  }
  return vim.g.heirline_colors
end

local statusLines = require 'rc.heirline.StatusLines'
local winBar = require 'rc.heirline.WinBar'
local tabLine = require 'rc.heirline.TabLine'
local statusColumn = require 'rc.heirline.StatusColumn'

require('heirline').setup {
  statusline = statusLines,
  winbar = winBar,
  tabline = tabLine,
  statuscolumn = statusColumn,
  opts = {
    disable_winbar_cb = function(args)
      local buf = args.buf
      local buftype = vim.tbl_contains({ 'prompt', 'nofile', 'help', 'quickfix' }, vim.bo[buf].buftype)
      local filetype = vim.tbl_contains({ 'gitcommit', 'fugitive', 'Trouble', 'packer' }, vim.bo[buf].filetype)
      return buftype or filetype
    end,
    colors = setup_colors,
  },
}

vim.o.statuscolumn = require('heirline').eval_statuscolumn()

vim.api.nvim_create_autocmd('ColorScheme', {
  group = 'VimRc',
  callback = function()
    utils.on_colorscheme(setup_colors)
  end,
})
-- }}}
