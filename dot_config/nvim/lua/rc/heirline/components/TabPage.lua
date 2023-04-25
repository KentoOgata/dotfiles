return {
  provider = function(self)
    local n = #vim.api.nvim_tabpage_list_wins(self.tabpage)
    return '%' .. self.tabnr .. 'T ' .. self.tabnr .. '(' .. n .. ')' .. ' %T'
  end,
  hl = function(self)
    if not self.is_active then
      return 'TabLine'
    else
      return 'TabLineSel'
    end
  end,
  update = { 'TabNew', 'TabClosed', 'TabEnter', 'TabLeave', 'WinNew', 'WinClosed' },
}
