---@param optname string
---@return function|nil
local function set(optname)
  if string.match(optname, '^no') then
    optname = string.sub(optname, 3)
    vim.o[optname] = false
  elseif type(vim.o[optname]) == 'boolean' then
    vim.o[optname] = true
  else
    ---@param val type(vim.o[optname])
    return function(val)
      if type(val) == 'table' then
        vim.opt[optname] = val
      else
        vim.o[optname] = val
      end
    end
  end
end

local list = {
  __values = {},
  contains = function(self, value)
    for _, v in ipairs(self.__values) do
      if v == value then
        return true
      end
    end
    return false
  end,
  new = function(self, values)
    return {
      __values = values,
      contains = self.contains,
    }
  end,
}

return {
  setup = function()
    set 'ignorecase'
    set 'smartcase'
    set 'wrapscan'
    set 'hlsearch'
    set 'autoindent'
    set 'smartindent'
    set 'smarttab'
    set 'shiftround'
    set 'hidden'
    set 'noswapfile'
    set 'updatetime'(30)
    set 'number'
    set 'relativenumber'
    set 'nocursorline'
    set 'termguicolors'
    set 'cmdheight'(1)
    set 'laststatus'(0)
    set 'showtabline'(0)
    set 'mouse' 'n'
    set 'secure'
    set 'inccommand' 'split'
    set 'fileencodings' { 'utf-8', 'cp932' }
    set 'fileformats' { 'unix', 'dos', 'mac' }

    if vim.bool_fn.executable 'rg' then
      set 'grepprg' 'rg --vimgrep --ignore-case'
      set 'grepformat' { '%f:%l:%m', '%f:%l%m', '%f  %l%m' }
    end

    vim.autocmd.create('OptionSet', {
      group = vim.augroup.GetOrAdd 'VimRc',
      pattern = 'bufhidden',
      desc = 'Set nobuflisted if bufhidden is wipe or delete',
      callback = function(ctx)
        local bufhidden = vim.v.option_new
        vim.bo[ctx.buf].buflisted = not ('wipe' == bufhidden or 'delete' == bufhidden)
      end,
    })

    vim.autocmd.create('BufWinEnter', {
      group = vim.augroup.GetOrAdd 'VimRc',
      desc = '`set wrap` when the buffer is markdown',
      callback = function(ctx)
        local fileTypes = list:new {
          'markdown',
          'org',
          'telekasten',
        }
        local winid = vim.api.nvim_get_current_win()
        if fileTypes:contains(vim.bo[ctx.buf].filetype) then
          vim.wo[winid].wrap = true
        else
          vim.wo[winid].wrap = false
        end
      end,
    })

    vim.autocmd.create('FileType', {
      group = vim.augroup.GetOrAdd 'VimRc',
      desc = 'FileTypeに応じてtab幅を設定する',
      callback = function(ctx)
        local twoTabFts = list:new {
          'css',
          'fish',
          'html',
          'javascript',
          'javascriptreact',
          'json',
          'lua',
          'query',
          'toml',
          'typescript',
          'typescriptreact',
          'vim',
          'xml',
          'yaml',
          'zsh',
        }
        local fourTabFts = list:new {
          'cs',
          'markdown',
        }

        local function setTabWidth(bufnr, tabWidth)
          vim.bo[bufnr].expandtab = true
          vim.bo[bufnr].tabstop = tabWidth
          vim.bo[bufnr].shiftwidth = tabWidth
          vim.bo[bufnr].softtabstop = 0
        end

        local ft = ctx.match
        if twoTabFts:contains(ft) then
          setTabWidth(ctx.buf, 2)
        elseif fourTabFts:contains(ft) then
          setTabWidth(ctx.buf, 4)
        end
      end,
    })
  end,
}
