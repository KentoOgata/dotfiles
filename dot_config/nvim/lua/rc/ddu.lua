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

local function getUiParamsOfWindowSize()
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

  return {
    ff = {
      winHeight = height,
      winRow = row,
      winWidth = width,
      winCol = col,
      previewWidth = math.floor(width / 2),
      previewHeight = previewHeight,
      previewSplit = previewSplit,
    },
  }
end

---@param config string|table
local function ddu(config)
  -- config is source name
  if type(config) == 'string' then
    return function()
      vim.fn['ddu#start'] {
        uiParams = getUiParamsOfWindowSize(),
        sources = {
          {
            name = config,
          },
        },
      }
    end
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

    return function()
      vim.fn['ddu#start'](vim.tbl_deep_extend('keep', normalizedConfig, {
        uiParams = getUiParamsOfWindowSize(),
      }))
    end
  end
end

return {
  setup = function()
    vim.fn['ddu#custom#action']('kind', 'file', 'openProject', function(dduContext)
      vim.fn['ddu#ui#do_action'] 'quit'
      local path = dduContext.items[1].action.path
      vim.fn['ddu#start'] {
        uiParams = getUiParamsOfWindowSize(),
        sources = {
          {
            name = 'file_external',
          },
        },
        sourceOptions = {
          file_external = {
            path = path,
          },
        },
      }
    end)

    vim.fn['ddu#custom#patch_global'] {
      ui = 'ff',
      uiParams = {
        ff = {
          startFilter = true,
          prompt = '> ',
          split = 'floating',
          floatingBorder = 'single',
          splitDirection = 'belowright',
          filterSplitDirection = 'floating',
          filterFloatingPosition = 'top',
          previewFloating = true,
          previewFloatingBorder = 'single',
          previewFloatingTitle = 'Preview',
          highlights = {
            floating = 'Normal',
            floatingBorder = 'Normal',
          },
        },
      },
      sourceOptions = {
        _ = {
          matchers = { 'matcher_fzf' },
          sorters = { 'sorter_fzf' },
          converters = { 'converter_devicon' },
        },
        help = {
          converters = {},
        },
        rg = {
          matchers = {},
          sorters = {},
          converters = {},
          volatile = true,
        },
        line = {
          matchers = { 'matcher_substring' },
          sorters = {},
          converters = {},
        },
        mr = {
          sorters = {},
        },
        dein = {
          defaultAction = 'openProject',
        },
        ghq = {
          defaultAction = 'openProject',
        },
      },
      kindOptions = {
        _ = {
          defaultAction = 'open',
        },
      },
      filterParams = {
        matcher_fzf = {
          highlightMatched = 'Search',
        },
        matcher_substring = {
          highlightMatched = 'Search',
        },
      },
      sourceParams = {
        file_external = {
          cmd = { 'fd', '-t', 'file' },
        },
        buffer = {
          orderby = 'asc',
        },
        lsp_references = {
          includeDeclaration = false,
        },
      },
    }

    ---A wrapper of vim.keymap.set()
    ---@param lhs string
    ---@param rhs string|function
    ---@param opts? table
    local function nmap(lhs, rhs, opts)
      vim.keymap.set('n', lhs, rhs, opts)
    end

    nmap('<Plug>(ddu-buffers)', ddu 'buffer')
    nmap('<Plug>(ddu-files)', ddu 'file_external')
    nmap('<Plug>(ddu-rg)', ddu 'rg')
    nmap('<Plug>(ddu-lines)', ddu 'line')
    nmap(
      '<Plug>(ddu-mrw)',
      ddu {
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

    nmap(
      '<Plug>(ddu-help_tags)',
      ddu {
        'help',
        uiParams = {
          ff = {
            autoAction = {
              name = 'preview',
            },
          },
        },
      }
    )

    nmap(
      '<Plug>(ddu-lsp_implementations)',
      ddu {
        uiParams = {
          ff = {
            autoAction = {
              name = 'preview',
            },
          },
        },
        sources = {
          {
            name = 'lsp_defenition',
            params = {
              method = 'textDocument/implementation',
            },
          },
        },
      }
    )

    nmap(
      '<Plug>(ddu-lsp_references)',
      ddu {
        'lsp_references',
        uiParams = {
          ff = {
            autoAction = {
              name = 'preview',
            },
          },
        },
      }
    )

    nmap(
      '<Plug>(ddu-resume)',
      ddu {
        resume = true,
        uiParams = {
          ff = {
            startFilter = false,
          },
        },
      }
    )

    nmap(
      '<Plug>(ddu-config_files)',
      ddu {
        'file_external',
        sourceOptions = {
          file_external = {
            path = vim.fs.joinpath(vim.env.XDG_DATA_HOME, 'chezmoi'),
          },
        },
      }
    )

    vim.api.nvim_create_user_command('DduPlugins', ddu 'dein', {})
    vim.api.nvim_create_user_command('DduGhq', ddu 'ghq', {})

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
            {
              'p',
              function()
                if not vim.b[ctx.buf].previewEnabled then
                  vim.b[ctx.buf].previewEnabled = true
                else
                  vim.b[ctx.buf].previewEnabled = false
                  vim.fn['ddu#ui#do_action'] 'preview'
                end
              end,
              { desc = 'toggle preview' },
            },
          },
        }

        if vim.b[ctx.buf].autoPreviewAuId == nil then
          vim.b[ctx.buf].autoPreviewAuId = vim.api.nvim_create_autocmd('CursorMoved', {
            group = 'VimRc',
            buffer = ctx.buf,
            desc = 'b:previewEnabled -> preview',
            callback = function()
              if vim.b[ctx.buf].previewEnabled then
                vim.fn['ddu#ui#do_action'] 'preview'
              end
            end,
          })
        end

        if vim.b[ctx.buf].previewDisableAuId == nil then
          vim.b[ctx.buf].previewDisableAuId = vim.api.nvim_create_autocmd('WinLeave', {
            group = 'VimRc',
            buffer = ctx.buf,
            desc = 'Disable auto preview',
            callback = function()
              if vim.b[ctx.buf].previewEnabled then
                vim.b[ctx.buf].previewEnabled = false
              end
            end,
          })
        end
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
  end,
}
