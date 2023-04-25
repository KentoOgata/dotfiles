---@diagnostic disable: duplicate-doc-field, duplicate-doc-alias

---@param other table
---@return table
---@diagnostic disable-next-line: duplicate-set-field
function table:extend(other)
  local new = {}
  for k, v in pairs(self) do
    new[k] = v
  end

  for k, v in pairs(other) do
    new[k] = v
  end
  return new
end

---@class vim.AutocmdArgs
---@field id integer autocommand id
---@field event vim.AutocmdEvent name of the triggered event `autocmd-events`
---@field group? integer autocommand group id, if any
---@field match string expanded value of <amatch>
---@field buf integer expanded value of <afile>
---@field file string expanded value of <afile>
---@field data any arbitary data passed to `nvim_exec_autocmds()`

---@class vim.AutocmdOpts
---@field group? string|integer
---@field pattern? string|string[]
---@field buffer? integer
---@field desc? string
---@field callback? string|fun(ctx: vim.AutocmdArgs):nil
---@field command? string
---@field once? boolean
---@field nested? boolean

if vim.autocmd == nil then
  vim.autocmd = {
    ---@enum vim.AutocmdEvent
    events = {
      BufAdd = 'BufAdd',
      BufDelete = 'BufDelete',
      BufEnter = 'BufEnter',
      BufFilePost = 'BufFilePost',
      BufFilePre = 'BufFilePre',
      BufHidden = 'BufHidden',
      BufLeave = 'BufLeave',
      BufModifiedSet = 'BufModifiedSet',
      BufNew = 'BufNew',
      BufNewFile = 'BufNewFile',
      BufReadPost = 'BufReadPost',
      BufReadCmd = 'BufReadCmd',
      BufReadPre = 'BufReadPre',
      BufUnload = 'BufUnload',
      BufWinEnter = 'BufWinEnter',
      BufWinLeave = 'BufWinLeave',
      BufWipeout = 'BufWipeout',
      BufWritePre = 'BufWritePre',
      BufWriteCmd = 'BufWriteCmd',
      BufWritePost = 'BufWritePost',
      ChanInfo = 'ChanInfo',
      ChanOpen = 'ChanOpen',
      CmdUndefined = 'CmdUndefined',
      CmdlineChanged = 'CmdlineChanged',
      CmdlineEnter = 'CmdlineEnter',
      CmdlineLeave = 'CmdlineLeave',
      CmdwinEnter = 'CmdwinEnter',
      CmdwinLeave = 'CmdwinLeave',
      ColorScheme = 'ColorScheme',
      ColorSchemePre = 'ColorSchemePre',
      CompleteChanged = 'CompleteChanged',
      CompleteDonePre = 'CompleteDonePre',
      CompleteDone = 'CompleteDone',
      CursorHold = 'CursorHold',
      CursorHoldI = 'CursorHoldI',
      CursorMoved = 'CursorMoved',
      CursorMovedI = 'CursorMovedI',
      DiffUpdated = 'DiffUpdated',
      DirChanged = 'DirChanged',
      DirChangedPre = 'DirChangedPre',
      DiagnosticChanged = 'DiagnosticChanged',
      ExitPre = 'ExitPre',
      FileAppendCmd = 'FileAppendCmd',
      FileAppendPost = 'FileAppendPost',
      FileAppendPre = 'FileAppendPre',
      FileChangedRO = 'FileChangedRO',
      FileChangedShell = 'FileChangedShell',
      FileChangedShellPost = 'FileChangedShellPost',
      FileReadCmd = 'FileReadCmd',
      FileReadPost = 'FileReadPost',
      FileReadPre = 'FileReadPre',
      FileType = 'FileType',
      FileWriteCmd = 'FileWriteCmd',
      FileWritePost = 'FileWritePost',
      FileWritePre = 'FileWritePre',
      FilterReadPost = 'FilterReadPost',
      FilterReadPre = 'FilterReadPre',
      FilterWritePost = 'FilterWritePost',
      FilterWritePre = 'FilterWritePre',
      FocusGained = 'FocusGained',
      FocusLost = 'FocusLost',
      FuncUndefined = 'FuncUndefined',
      UIEnter = 'UIEnter',
      UILeave = 'UILeave',
      InsertChange = 'InsertChange',
      InsertCharPre = 'InsertCharPre',
      InsertEnter = 'InsertEnter',
      InsertLeavePre = 'InsertLeavePre',
      InsertLeave = 'InsertLeave',
      MenuPopup = 'MenuPopup',
      ModeChanged = 'ModeChanged',
      OptionSet = 'OptionSet',
      QuickFixCmdPre = 'QuickFixCmdPre',
      QuickFixCmdPost = 'QuickFixCmdPost',
      QuitPre = 'QuitPre',
      RemoteReply = 'RemoteReply',
      SearchWrapped = 'SearchWrapped',
      RecordingEnter = 'RecordingEnter',
      RecordingLeave = 'RecordingLeave',
      SessionLoadPost = 'SessionLoadPost',
      ShellCmdPost = 'ShellCmdPost',
      Signal = 'Signal',
      ShellFilterPost = 'ShellFilterPost',
      SourcePre = 'SourcePre',
      SourcePost = 'SourcePost',
      SourceCmd = 'SourceCmd',
      SpellFileMissing = 'SpellFileMissing',
      StdinReadPost = 'StdinReadPost',
      StdinReadPre = 'StdinReadPre',
      SwapExists = 'SwapExists',
      Syntax = 'Syntax',
      TabEnter = 'TabEnter',
      TabLeave = 'TabLeave',
      TabNew = 'TabNew',
      TabNewEntered = 'TabNewEntered',
      TabClosed = 'TabClosed',
      TermOpen = 'TermOpen',
      TermEnter = 'TermEnter',
      TermLeave = 'TermLeave',
      TermClose = 'TermClose',
      TermResponse = 'TermResponse',
      TextChanged = 'TextChanged',
      TextChangedI = 'TextChangedI',
      TextChangedP = 'TextChangedP',
      TextChangedT = 'TextChangedT',
      TextYankPost = 'TextYankPost',
      User = 'User',
      UserGettingBored = 'UserGettingBored',
      VimEnter = 'VimEnter',
      VimLeave = 'VimLeave',
      VimLeavePre = 'VimLeavePre',
      VimResized = 'VimResized',
      VimResume = 'VimResume',
      VimSuspend = 'VimSuspend',
      WinClosed = 'WinClosed',
      WinEnter = 'WinEnter',
      WinLeave = 'WinLeave',
      WinNew = 'WinNew',
      WinScrolled = 'WinScrolled',
      WinResized = 'WinResized',
      LspAttach = 'LspAttach',
      LspDetach = 'LspDetach',
    },
    ---@param event vim.AutocmdEvent|vim.AutocmdEvent[]
    ---@param opts vim.AutocmdOpts
    ---@return integer
    create = function(event, opts)
      return vim.api.nvim_create_autocmd(event, opts)
    end,
    ---@param predicate integer|table
    delete = function(predicate)
      if type(predicate) == 'number' then
        vim.api.nvim_del_autocmd(predicate)
      elseif type(predicate) == 'table' then
        vim.api.nvim_clear_autocmds(predicate)
      end
    end,
  }
else
  error 'vim.autocmd is provided as official api. Use that.'
end

if vim.augroup == nil then
  vim.augroup = {
    ---@param name string
    ---@param opts? { clear: boolean }
    ---@return number
    GetOrAdd = function(name, opts)
      return vim.api.nvim_create_augroup(name, opts or { clear = false })
    end,
    ---@param id string|number
    delete = function(id)
      if type(id) == 'number' then
        vim.api.nvim_del_augroup_by_id(id)
      elseif type(id) == 'string' then
        vim.api.nvim_del_augroup_by_name(id)
      else
        error 'Invalid type of id. It is expected to number or string.'
      end
    end,
  }
else
  error 'vim.augroup is provided as official api. Use that.'
end

-- ORIGINAL:
-- https://scrapbox.io/vim-jp/boolean%E3%81%AA%E5%80%A4%E3%82%92%E8%BF%94%E3%81%99vim.fn%E3%81%AEwrapper_function
vim.bool_fn = setmetatable({}, {
  __index = function(_, key)
    return function(...)
      local v = vim.fn[key](...)
      if not v or v == 0 or v == '' then
        return false
      elseif type(v) == 'table' and next(v) == nil then
        return false
      else
        return true
      end
    end
  end,
})

---@param config { mode: string|table, maps: table, opts: table|nil }
function vim.keymap.set_table(config)
  for _, map in ipairs(config.maps) do
    local lhs, rhs, opts = map[1], map[2], ((map[3] and config.opts) and table.extend(config.opts, map[3])) or map[3]

    vim.keymap.set(config.mode, lhs, rhs, opts or config.opts)
  end
end
