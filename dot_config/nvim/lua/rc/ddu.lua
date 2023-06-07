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

---@param source string|table
local function ddu(source)
  if type(source) == 'string' then
    return function()
      vim.fn['ddu#start'] {
        sources = {
          {
            name = source,
          },
        },
      }
    end
  elseif type(source) == 'table' then
    return function()
      vim.fn['ddu#start'] {
        sources = {
          source,
        },
      }
    end
  end
end

return {
  setup = function()
    local lines = vim.opt.lines:get()
    local height, row = math.floor(lines * 0.8), math.floor(lines * 0.1)
    local columns = vim.opt.columns:get()
    local width, col = math.floor(columns * 0.8), math.floor(columns * 0.1)

    vim.fn['ddu#custom#patch_global'] {
      ui = 'ff',
      uiParams = {
        ff = {
          startFilter = true,
          prompt = '> ',
          split = 'floating',
          winHeight = height,
          winRow = row,
          winWidth = width,
          winCol = col,
          floatingBorder = 'single',
          splitDirection = 'belowright',
          filterSplitDirection = 'floating',
          filterFloatingPosition = 'top',
          -- autoAction = {
          --   name = 'preview',
          -- },
          previewFloating = true,
          previewFloatingBorder = 'single',
          previewSplit = 'vertical',
          previewFloatingTitle = 'Preview',
          previewWidth = math.floor(width / 2),
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
      },
      sourceParams = {
        file_external = {
          cmd = { 'fd', '-t', 'file' },
        },
        buffer = {
          orderby = 'asc',
        },
      },
    }

    vim.keymap.set('n', '<Plug>(ddu-buffers)', ddu 'buffer')
    vim.keymap.set('n', '<Plug>(ddu-files)', ddu 'file_external')
    vim.keymap.set('n', '<Plug>(ddu-help_tags)', ddu 'help')
    vim.keymap.set('n', '<Plug>(ddu-rg)', ddu 'rg')
    vim.keymap.set('n', '<Plug>(ddu-lines)', ddu 'line')

    vim.keymap.set('n', '<Plug>(ddu-resume)', function()
      vim.fn['ddu#start'] {
        resume = true,
        uiParams = {
          ff = {
            startFilter = false,
          },
        },
      }
    end)

    vim.keymap.set('n', '<Plug>(ddu-config_files)', function()
      vim.fn['ddu#start'] {
        sources = {
          {
            name = 'file_external',
          },
        },
        sourceOptions = {
          file_external = {
            path = vim.fs.joinpath(vim.env.XDG_DATA_HOME, 'chezmoi'),
          },
        },
      }
    end)

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
  end,
}
