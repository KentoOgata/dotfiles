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

local function dduAction(action)
  return function()
    vim.fn['ddu#ui#do_action'](action)
  end
end

return {
  setup = function()
    vim.keymap.set('n', '<Plug>(ddu-buffers)', function()
      vim.fn['ddu#start'] {
        ui = 'ff',
        uiParams = ffUiParams,
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
            { '<CR>', dduAction 'itemAction' },
            { 'i', dduAction 'openFilterWindow' },
            { 'q', dduAction 'quit' },
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
        vim.keymap.set('n', '<CR>', dduAction 'closeFilterWindow', { buffer = ctx.buf })
        vim.keymap.set('n', 'q', dduAction 'quit', { buffer = ctx.buf })
      end,
    })
  end,
}
