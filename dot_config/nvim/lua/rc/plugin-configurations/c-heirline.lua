vim.go.laststatus = 2
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
    bright_bg = utils.get_highlight('Folded').bg,
    bright_fg = utils.get_highlight('Folded').fg,
    red = utils.get_highlight('DiagnosticError').fg,
    dark_red = utils.get_highlight('DiffDelete').bg,
    green = utils.get_highlight('String').fg,
    blue = utils.get_highlight('Function').fg,
    gray = utils.get_highlight('NonText').fg,
    orange = utils.get_highlight('Constant').fg,
    purple = utils.get_highlight('Statement').fg,
    cyan = utils.get_highlight('Special').fg,
    diag_warn = utils.get_highlight('DiagnosticWarn').fg,
    diag_error = utils.get_highlight('DiagnosticError').fg,
    diag_hint = utils.get_highlight('DiagnosticHint').fg,
    diag_info = utils.get_highlight('DiagnosticInfo').fg,
    git_del = utils.get_highlight('diffRemoved').fg,
    git_add = utils.get_highlight('diffAdded').fg,
    git_change = utils.get_highlight('diffChanged').fg,
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

vim.autocmd.create('ColorScheme', {
  group = vim.augroup.GetOrAdd 'VimRc',
  callback = function()
    utils.on_colorscheme(setup_colors)
  end,
})
