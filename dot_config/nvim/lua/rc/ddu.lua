return {
  setup = function()
    vim.keymap.set('n', '<Plug>(ddu-buffers)', function()
      vim.fn['ddu#start'] {
        ui = 'ff',
        uiParams = {
          split = 'no',
          startFilter = true,
        },
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
        local function dduAction(action)
          return function()
            vim.fn['ddu#ui#do_action'](action)
          end
        end
        vim.keymap.set_table {
          mode = 'n',
          opts = {
            buffer = ctx.buf,
          },
          maps = {
            {
              '<CR>',
              dduAction 'itemAction',
            },
            {
              'i',
              dduAction 'openFilterWindow',
            },
            {
              'q',
              dduAction 'quit',
            },
          },
        }
      end,
    })
  end,
}
