-- lua_add {{{
-- ORIGINAL: https://zenn.dev/kawarimidoll/articles/daa39da5838567

-- <C-w>xと<C-w><C-x>を同時に設定する
local win_keymap_set = function(key, callback)
  vim.keymap.set({ 'n' }, '<C-w>' .. key, callback)
  vim.keymap.set({ 'n' }, '<C-w><C-' .. key .. '>', callback)
end

win_keymap_set('w', function()
  local wins = #vim
    .iter(vim.api.nvim_tabpage_list_wins(0))
    :filter(function(winnr)
      local conf = vim.api.nvim_win_get_config(winnr)
      return conf.focusable
    end)
    :totable()

  if wins > 2 then
    require('chowcho').run()
  else
    vim.cmd.wincmd 'w'
  end
end)
-- }}}
