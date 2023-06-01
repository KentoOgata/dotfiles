local ffUiParams = {
  ff = {
    split = 'horizontal',
    splitDirection = 'belowright',
    filterSplitDirection = 'floating',
    filterFloatingPosition = 'bottom',
    startFilter = false,
    winHeight = 10,
  },
}

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

return {
  setup = function()
    vim.keymap.set('n', '<Plug>(ddu-buffers)', function()
      vim.fn['ddu#start'] {
        ui = 'ff',
        uiParams = vim.tbl_deep_extend('force', ffUiParams, { ff = { startFilter = true } }),
        sources = {
          {
            name = 'buffer',
            params = {
              orderby = 'asc',
            },
          },
        },
        sourceOptions = {
          buffer = {
            defaultAction = 'open',
            matchers = {
              'matcher_fzf',
            },
          },
        },
        filterParams = {
          matcher_fzf = {
            highlightMatched = 'Search',
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
      desc = 'Setup keymaps of ddu-ui-ff',
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
