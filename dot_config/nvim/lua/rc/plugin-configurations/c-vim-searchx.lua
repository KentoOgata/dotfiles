vim.keymap.set_table {
  mode = { 'n', 'x' },
  maps = {
    {
      '<Plug>(searchx-start:forward)',
      function()
        vim.fn['searchx#start'] { dir = 1 }
      end,
    },
    {
      '<Plug>(searchx-start:backward)',
      function()
        vim.fn['searchx#start'] { dir = 0 }
      end,
    },
  },
}

vim.keymap.set_table {
  mode = { 'n', 'x', 'o', 'c' },
  maps = {
    { '<Plug>(searchx-next-dir)', vim.fn['searchx#next_dir'] },
    { '<Plug>(searchx-prev-dir)', vim.fn['searchx#prev_dir'] },
    { '<Plug>(searchx-next)', vim.fn['searchx#next'] },
    { '<Plug>(searchx-prev)', vim.fn['searchx#prev'] },
  },
}

local migemo_prompt = '(Migemo):'

vim.g.searchx = {
  auto_accept = true,
  scrolloff = vim.o.scrolloff,
  scrolltime = 15,
  nohlsearch = {
    jump = true,
  },
  markers = vim.fn['split']('ASDFGHJKLQWERTYUIOPZXCVBNM', '.\\zs'),
  ---@param input string
  convert = function(input)
    -- migemo Prompt付きで検索しているとき
    if input:sub(1, migemo_prompt:len()) == migemo_prompt then
      -- migemo Promptを除外する
      input = input:sub(migemo_prompt:len() + 1)
      -- 二文字未満の場合はそのまま検索する(候補が多すぎる)
      if input:len() < 2 then
        return input
      else
        -- 入力の文字列をmigemoしたクエリで検索する
        return vim.fn['kensaku#query'](input)
      end
    else
      -- 空白で隔てられた文字列の間に任意の文字列があってもマッチする
      return string.gsub(input, '%s', [[.\{-}]])
    end
  end,
}

-- <C-j>でmigemo検索に切り替える
vim.keymap.set('c', '<C-j>', function()
  local cmdtype = vim.fn.getcmdtype()
  if cmdtype == '@' then
    local cmdline = vim.fn.getcmdline()
    if cmdline:sub(1, migemo_prompt:len()) == migemo_prompt then
      vim.fn.setcmdline(cmdline:sub(migemo_prompt:len() + 1))
    else
      vim.fn.setcmdline(migemo_prompt .. cmdline)
    end
  end
end)

local gid = vim.augroup.GetOrAdd 'SearchxRc'

vim.autocmd.create('User', {
  group = gid,
  pattern = 'SearchxEnter',
  callback = function()
    vim.wo.cursorline = false
  end,
})

vim.autocmd.create('User', {
  group = gid,
  pattern = 'SearchxAccept',
  callback = function()
    vim.wo.cursorline = true
  end,
})

vim.autocmd.create('User', {
  group = gid,
  pattern = 'SearchxAccept',
  callback = function()
    if vim.v['searchforward'] == 0 then
      vim.notify 'v:searchforward:0'
    end
  end,
})
