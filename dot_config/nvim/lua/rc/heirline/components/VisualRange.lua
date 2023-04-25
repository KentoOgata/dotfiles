-- WIP
return {
  condition = function()
    return vim.tbl_containsvim({ 'V', 'v' }, vim.fn.mode())
  end,
  provider = function()
    local start = vim.fn.getpos '\'<'
    local stop = vim.fn.getpos '\'>'
  end,
}
