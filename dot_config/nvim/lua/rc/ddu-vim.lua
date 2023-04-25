---@type dein.Plugins
local plugins = {}

plugins['Shougo/ddu.vim'] = {
  depends = 'denops.vim',
  lazy = false,
}

plugins['Shougo/ddu-source-file'] = {
  depends = { 'denops.vim', 'ddu.vim', 'ddu-kind-file' },
  lazy = false,
}

plugins['Shougo/ddu-source-line'] = {
  depends = { 'denops.vim', 'ddu.vim', 'ddu-kind-file' },
  lazy = false,
}

plugins['Shougo/ddu-source-file_external'] = {
  depends = { 'denops.vim', 'ddu.vim', 'ddu-kind-file' },
  lazy = false,
}

plugins['shun/ddu-source-rg'] = {
  depends = { 'denops.vim', 'ddu.vim', 'ddu-kind-file' },
  lazy = false,
  enabled = vim.bool_fn.executable 'rg',
}

plugins['shun/ddu-source-buffer'] = {
  depends = { 'denops.vim', 'ddu.vim', 'ddu-kind-file' },
  lazy = false,
}

plugins['matsui54/ddu-source-help'] = {
  depends = { 'denops.vim', 'ddu.vim' },
  lazy = false,
}

plugins['matsui54/ddu-source-command_history'] = {
  depends = { 'denops.vim', 'ddu.vim' },
  lazy = false,
}

plugins['Shougo/ddu-source-file_old'] = {
  depends = { 'denops.vim', 'ddu.vim', 'ddu-kind-file' },
  lazy = false,
}

plugins['yuki-yano/ddu-filter-fzf'] = {
  depends = { 'denops.vim', 'ddu.vim' },
  lazy = false,
}

plugins['Shougo/ddu-filter-matcher_substring'] = {
  depends = { 'denops.vim', 'ddu.vim' },
  lazy = false,
}

plugins['Shougo/ddu-column-filename'] = {
  depends = { 'denops.vim', 'ddu.vim' },
  lazy = false,
}

plugins['Shougo/ddu-kind-file'] = {
  depends = { 'denops.vim', 'ddu.vim' },
  lazy = false,
}

plugins['Shougo/ddu-kind-word'] = {
  depends = { 'denops.vim', 'ddu.vim' },
  lazy = false,
}

plugins['Shougo/ddu-ui-ff'] = {
  lazy = false,
  depends = {
    'denops.vim',
    'ddu.vim',
    'ddu-source-file_external',
    'ddu-source-file_old',
    'ddu-source-line',
    'ddu-source-help',
    'ddu-source-buffer',
    'ddu-source-rg',
    'ddu-source-command_history',
    'ddu-filter-fzf',
    'ddu-filter-matcher_substring',
  },
  hook_add = function()
    vim.api.nvim_create_user_command('MapDduFf', function()
      vim.keymap.set_table {
        mode = 'n',
        maps = {
          { '<Plug>(ff-file)', '<Plug>(ddu-ff-file)' },
          { '<Plug>(ff-oldfiles)', '<Plug>(ddu-ff-oldfiles)' },
          { '<Plug>(ff-word:grep)', '<Plug>(ddu-ff-rg)' },
          { '<Plug>(ff-word:cbuf)', '<Plug>(ddu-ff-line)' },
          { '<Plug>(ff-buffer)', '<Plug>(ddu-ff-buffer)' },
          { '<Plug>(ff-help)', '<Plug>(ddu-ff-help)' },
          { '<Plug>(ff-resume)', '<Plug>(ddu-ff-resume)' },
          { '<Plug>(ff-vimrc)', '<Plug>(ddu-ff-vimrc)' },
          { '<Plug>(ff-git-status)', '<Plug>(ddu-ff-git)' },
          { '<Plug>(ff-command_history)', '<Plug>(ddu-ff-commandline_history)' },
        },
      }
    end, {})

    vim.keymap.set('n', '<Space>fp', '<Plug>(ddu-ff-dein)')

    local shared_opts = {
      resume = false,
      ui = 'ff',
      uiParams = {
        ff = {
          autoResize = true,
          filterSplitDirection = 'belowright',
          -- filterのウィンドウをfloatにしてると間違えてwinbar設定したときに動かなくなってつらいので
          -- floatにはしないことにした
          split = 'horizontal',
          floatingBorder = 'single',
          displaySourceName = 'no',
          previewFloating = true,
          previewFloatingBorder = 'single',
          previewWidth = vim.go.columns / 2,
          startFilter = true,
        },
      },
      sourceOptions = {
        _ = {
          ignoreCase = true,
          matchers = { 'matcher_fzf' },
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
      kindOptions = {
        file = {
          defaultAction = 'open',
        },
        word = {
          defaultAction = 'append',
        },
        help = {
          defaultAction = 'open',
        },
        command_history = {
          defaultAction = 'execute',
        },
      },
    }

    -- resume
    vim.keymap.set('n', '<Plug>(ddu-ff-resume)', function()
      vim.fn['ddu#start'](table.extend(shared_opts, {
        name = 'search',
        resume = true,
        uiParams = {
          ff = {
            startFilter = false,
          },
        },
      }))
    end)

    -- dein plugins source
    vim.keymap.set('n', '<Plug>(ddu-ff-dein)', function()
      vim.fn['ddu#start'](table.extend(shared_opts, {
        sources = { {
          name = 'dein',
        } },
      }))
    end)

    -- line source
    vim.keymap.set('n', '<Plug>(ddu-ff-line)', function()
      vim.fn['ddu#start'](table.extend(shared_opts, {
        name = 'search',
        sources = {
          {
            name = 'line',
            options = {
              matchers = { 'matcher_substring' },
              params = {
                range = 'buffer',
              },
            },
          },
        },
      }))
    end)

    local fd = { 'fd', '.', '-H', '-E', '.git', '-E', '__pycache__', '-E', 'node_modules', '-t', 'file' }
    local git_status = { 'git', 'ls-files', '--modified', '--others', '--exclude-standard' }

    -- file source
    vim.keymap.set('n', '<Plug>(ddu-ff-file)', function()
      vim.fn['ddu#start'](table.extend(shared_opts, {
        name = 'search',
        sources = {
          {
            name = 'file_external',
            params = {
              cmd = fd,
            },
          },
        },
      }))
    end)

    -- git modified source
    vim.keymap.set('n', '<Plug>(ddu-ff-git)', function()
      vim.fn['ddu#start'](table.extend(shared_opts, {
        name = 'search',
        sources = {
          {
            name = 'file_external',
            options = {
              ignoreCase = true,
              matchers = { 'matcher_fzf' },
            },
            params = {
              cmd = git_status,
            },
          },
        },
      }))
    end)

    -- vimrc source
    vim.keymap.set('n', '<Plug>(ddu-ff-vimrc)', function()
      vim.fn['ddu#start'](table.extend(shared_opts, {
        sources = {
          {
            name = 'file_external',
            params = {
              cmd = fd,
              path = vim.env['DOTFILES'],
            },
          },
        },
      }))
    end)

    -- rg source
    vim.keymap.set('n', '<Plug>(ddu-ff-rg)', function()
      vim.fn['ddu#start'](table.extend(shared_opts, {
        name = 'search',
        sources = {
          {
            name = 'rg',
            options = {
              matchers = { 'matcher_substring' },
            },
            params = {
              args = { '--ignore-case', '--column', '--no-heading', '--color', 'never' },
              input = vim.fn.input { prompt = 'Pattern: ' },
            },
          },
        },
      }))
    end)

    -- buffer source
    vim.keymap.set('n', '<Plug>(ddu-ff-buffer)', function()
      vim.fn['ddu#start'](table.extend(shared_opts, {
        name = 'search',
        sources = {
          {
            name = 'buffer',
            options = {
              matchers = { 'matcher_fzf' },
            },
          },
        },
      }))
    end)

    -- help source
    vim.keymap.set('n', '<Plug>(ddu-ff-help)', function()
      local sources = {
        {
          name = 'help',
          options = {
            matchers = { 'matcher_fzf' },
          },
        },
      }
      local dein = require 'dein'
      if dein.is_available 'vim-readme-viewer' then
        if not dein.is_sourced 'vim-readme-viewer' then
          dein.source 'vim-readme-viewer'
        end

        table.insert(sources, { name = 'readme_viewer', options = { matchers = { 'matcher_fzf' } } })
      end

      vim.fn['ddu#start'](table.extend(shared_opts, {
        name = 'help',
        sources = sources,
      }))
    end)

    -- cmdline history source
    vim.keymap.set('n', '<Plug>(ddu-ff-commandline_history)', function()
      vim.fn['ddu#start'](table.extend(shared_opts, {
        sources = {
          {
            name = 'command_history',
            options = {
              matchers = { 'matcher_fzf' },
            },
          },
        },
      }))
    end)

    -- oldfiles source
    vim.keymap.set('n', '<Plug>(ddu-ff-oldfiles)', function()
      vim.fn['ddu#start'](table.extend(shared_opts, {
        name = 'search',
        sources = { {
          name = 'file_old',
        } },
      }))
    end)
  end,
  ftplugin = {
    ['ddu-ff'] = function(ctx)
      local ff = {
        action = vim.fn['ddu#ui#ff#do_action'],
      }

      ---@param command string
      local function finderAction(command)
        return function()
          ff.action(command)
        end
      end

      vim.keymap.set_table {
        mode = 'n',
        opts = {
          buffer = ctx.buf,
          nowait = true,
          silent = true,
        },
        maps = {
          { '<CR>', finderAction 'itemAction' },
          { 'i', finderAction 'openFilterWindow' },
          { 'q', finderAction 'quit' },
          {
            'p',
            function()
              local gid = vim.augroup.GetOrAdd('DduPreview', { clear = false })
              if not vim.b[ctx.buf].previewEnabled then
                vim.b[ctx.buf].previewEnabled = true
                ff.action 'preview'

                -- カーソルを移動したときにpreviewを更新する
                vim.b[ctx.buf].previewAuId = vim.autocmd.create('CursorMoved', {
                  buffer = ctx.buf,
                  group = gid,
                  callback = function()
                    ff.action 'preview'
                  end,
                })
                -- Windowから抜けたときに↑のautocmdを消す
                vim.autocmd.create('WinLeave', {
                  buffer = ctx.buf,
                  group = gid,
                  once = true,
                  callback = function()
                    vim.b[ctx.buf].previewEnabled = false
                    vim.autocmd.delete { group = gid }
                  end,
                })
              else
                vim.b[ctx.buf].previewEnabled = false
                vim.autocmd.delete { group = gid }
                ff.action 'preview'
              end
            end,
          },
        },
      }
    end,
    ['ddu-ff-filter'] = function(au_ctx)
      local buflocal = {
        buffer = au_ctx.buf,
        nowait = true,
        silent = true,
      }
      local function filterClose()
        vim.fn['ddu#ui#ff#do_action'] 'closeFilterWindow'
      end

      vim.keymap.set('i', '<CR>', '<Esc><Cmd>call ddu#ui#ff#do_action("closeFilterWindow")<CR>', buflocal)
      vim.keymap.set('n', '<CR>', filterClose, buflocal)
      vim.keymap.set('n', 'q', filterClose, buflocal)
    end,
  },
}

return plugins
