---@param action string
---@return function
local function uiAction(action)
  return function()
    vim.fn['ddu#ui#do_action'](action)
  end
end

---@param action string
---@param params? table
---@return function
local function itemAction(action, params)
  return function()
    vim.fn['ddu#ui#do_action']('itemAction', {
      name = action,
      params = params,
    })
  end
end

local function multiActions(actions)
  return function()
    vim.fn['ddu#ui#multi_actions'](vim
      .iter(actions)
      :map(function(action)
        if type(action) == 'table' then
          return action
        else
          return { action }
        end
      end)
      :totable())
  end
end

local function notifyWindowSizeToDdu()
  local lines = vim.opt.lines:get()
  local height, row = math.floor(lines * 0.8), math.floor(lines * 0.1)
  local columns = vim.opt.columns:get()
  local width, col = math.floor(columns * 0.8), math.floor(columns * 0.1)

  local previewSplit, previewHeight
  if columns < 200 then
    previewSplit = 'horizontal'
    previewHeight = math.floor(height / 2)
  else
    previewSplit = 'vertical'
    previewHeight = height
  end

  vim.fn['ddu#custom#patch_global'] {
    uiParams = {
      ff = {
        winHeight = height,
        winRow = row,
        winWidth = width,
        winCol = col,
        previewWidth = math.floor(width / 2),
        previewHeight = previewHeight,
        previewSplit = previewSplit,
      },
    },
  }
end

---@enum DduActionFlags
local actionFlags = {
  None = 0,
  RefreshItems = 1,
  Redraw = 2,
  Persist = 4,
  RestoreCursor = 8,
}

---@class DduCustomActionDefinition
---@field type 'kind'|'source'|'ui'
---@field name string
---@field actionName string
---@field func fun(args: any): DduActionFlags

---@param config string|table
---@return table
local function normalizeConfig(config)
  -- config is source name
  if type(config) == 'string' then
    return {
      sources = {
        {
          name = config,
        },
      },
    }
    -- config is arguments of ddu#start
  elseif type(config) == 'table' then
    -- sourceの指定は ddu.start { 'file' } みたいにできるようにする
    local normalizedConfig = {}
    for k, v in pairs(config) do
      if type(k) == 'number' then
        normalizedConfig.sources = normalizedConfig.sources or {}
        table.insert(normalizedConfig.sources, { name = v })
      else
        normalizedConfig[k] = v
      end
    end

    return vim.tbl_deep_extend('keep', normalizedConfig, {
      resume = false,
      name = 'default',
    })
  end

  return {}
end

---@param config string|table
local function dduStart(config)
  vim.fn['ddu#start'](normalizeConfig(config))
end

local ddu = {
  ---@param def DduCustomActionDefinition
  ---@return nil
  addCustomAction = function(def)
    vim.fn['ddu#custom#action'](def.type, def.name, def.actionName, def.func)
  end,
  ---@param config string|table
  getStartFunc = function(config)
    return function()
      dduStart(config)
    end
  end,
  start = dduStart,
}

local function setup()
  ddu.addCustomAction {
    type = 'kind',
    name = 'file',
    actionName = 'openProject',
    func = function(args)
      if #args.items == 0 then
        return actionFlags.None
      end
      local item = args.items[1]
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'ddu-ff',
        once = true,
        callback = function(ctx)
          local wins = vim
            .iter(vim.api.nvim_tabpage_list_wins(0))
            :filter(function(win)
              return vim.api.nvim_win_get_buf(win) == ctx.buf
            end)
            :totable()

          if #wins == 0 then
            return
          end
          local win = wins[1]

          vim.wo[win].winbar = item.action.path
        end,
      })
      vim.fn['ddu#start'] {
        sources = {
          {
            name = 'file_external',
          },
        },
        sourceParams = {
          file_external = {
            cmd = { 'git', 'ls-files', '-co', '--exclude-standard' },
          },
        },
        sourceOptions = {
          file_external = {
            path = item.action.path,
          },
        },
      }
      return actionFlags.None
    end,
  }

  vim.fn['ddu#custom#load_config'](vim.fs.joinpath(vim.env.DEIN_CONFIG_DIR, 'ddu.ts'))

  vim.api.nvim_create_autocmd('VimResized', {
    group = 'VimRc',
    callback = notifyWindowSizeToDdu,
  })

  notifyWindowSizeToDdu()

  ---A wrapper of vim.keymap.set()
  ---@param lhs string
  ---@param rhs string|function
  ---@param opts? table
  local function nmap(lhs, rhs, opts)
    vim.keymap.set('n', lhs, rhs, opts)
  end

  nmap('<Plug>(ddu-buffers)', ddu.getStartFunc 'buffer')
  nmap('<Plug>(ddu-files)', ddu.getStartFunc 'file_external')
  nmap('<Plug>(ddu-rg)', ddu.getStartFunc 'rg')
  nmap('<Plug>(ddu-lines)', ddu.getStartFunc 'line')
  nmap(
    '<Plug>(ddu-mrw)',
    ddu.getStartFunc {
      uiParams = {
        ff = {
          startFilter = false,
        },
      },
      sources = {
        {
          name = 'mr',
          params = {
            kind = 'mrw',
            current = true,
          },
        },
      },
    }
  )

  nmap('<Plug>(ddu-help_tags)', ddu.getStartFunc 'help')

  nmap(
    '<Plug>(ddu-lsp_implementations)',
    ddu.getStartFunc {
      uiParams = {
        ff = {
          startAutoAction = true,
          startFilter = false,
        },
      },
      sources = {
        {
          name = 'lsp_definition',
          params = {
            method = 'textDocument/implementation',
          },
        },
      },
    }
  )

  nmap(
    '<Plug>(ddu-lsp_references)',
    ddu.getStartFunc {
      'lsp_references',
      uiParams = {
        ff = {
          startAutoAction = true,
          startFilter = false,
        },
      },
    }
  )

  nmap(
    '<Plug>(ddu-resume)',
    ddu.getStartFunc {
      resume = true,
      name = 'default',
      uiParams = {
        ff = {
          startFilter = false,
        },
      },
    }
  )

  nmap(
    '<Plug>(ddu-config_files)',
    ddu.getStartFunc {
      'file_external',
      sourceOptions = {
        file_external = {
          path = vim.fs.joinpath(vim.env.XDG_DATA_HOME, 'chezmoi'),
        },
      },
    }
  )

  vim.api.nvim_create_user_command('DduPlugins', ddu.getStartFunc 'dein', {})
  vim.api.nvim_create_user_command('DduGhq', ddu.getStartFunc 'ghq', {})

  vim.api.nvim_create_autocmd('FileType', {
    group = 'VimRc',
    pattern = 'ddu-ff',
    desc = 'Setup keymaps of ddu-ff',
    callback = function(ctx)
      vim.keymap.set_table {
        mode = 'n',
        opts = {
          buffer = ctx.buf,
        },
        maps = {
          { '<CR>', uiAction 'itemAction' },
          { 'i', uiAction 'openFilterWindow' },
          { 'q', uiAction 'quit' },
          { 'd', itemAction 'delete' },
          { '<SPACE>', uiAction 'toggleSelectItem', { nowait = true } },
          { 'a', uiAction 'chooseAction' },
          { '<C-Space>', uiAction 'toggleAllItems' },
          { 'c', multiActions { 'toggleAllItems', { 'itemAction', { name = 'quickfix' } } } },
          { 'p', uiAction 'toggleAutoAction' },
          { 'l', uiAction 'expandItem' },
          { 'h', uiAction 'collapseItem' },
        },
      }
    end,
  })

  vim.api.nvim_create_autocmd('FileType', {
    group = 'VimRc',
    pattern = 'ddu-ff-filter',
    desc = 'Setup keymaps of ddu-ff-filter',
    callback = function(ctx)
      vim.keymap.set('i', '<CR>', function()
        vim.cmd.stopinsert()
        vim.fn['ddu#ui#do_action'] 'closeFilterWindow'
      end, { buffer = ctx.buf })
      vim.keymap.set('n', '<CR>', uiAction 'closeFilterWindow', { buffer = ctx.buf })
      vim.keymap.set('n', 'q', uiAction 'quit', { buffer = ctx.buf })
    end,
  })

  vim.keymap.set(
    'n',
    '<Plug>(lsp-codeAction)',
    ddu.getStartFunc {
      'lsp_codeAction',
      name = '_',
      uiParams = {
        ff = {
          startAutoAction = true,
          startFilter = false,
        },
      },
    }
  )
end

return setmetatable(ddu, {
  __index = function(t, k)
    if k == 'setup' then
      return setup
    else
      return t[k]
    end
  end,
})
