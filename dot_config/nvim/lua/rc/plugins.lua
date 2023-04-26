---@type dein.Plugins
local plugins = {}

plugins['hrsh7th/nvim-gtd'] = {
  on_map = '<Plug>(gtd:',
  hook_add = function()
    vim.keymap.set_table {
      mode = 'n',
      maps = {
        { 'gf<Space>', '<Plug>(gtd:edit)' },
        { 'gfH', '<Plug>(gtd:splitleft)' },
        { 'gfJ', '<Plug>(gtd:splitbelow)' },
        { 'gfK', '<Plug>(gtd:splitabove)' },
        { 'gfL', '<Plug>(gtd:splitright)' },
      },
    }
  end,
}

plugins['hrsh7th/nvim-pasta'] = {
  on_map = { '<Plug>(pasta-p)', '<Plug>(pasta-P)' },
  hook_add = function()
    vim.keymap.set_table {
      mode = { 'n', 'x' },
      maps = { { 'p', '<Plug>(pasta-p)' }, { 'P', '<Plug>(pasta-P)' } },
    }
    --map({ 'n' }, '<C-p>', '<Plug>(pasta-toggle_pin)')

    vim.autocmd.create('CmdwinEnter', {
      group = vim.augroup.GetOrAdd 'PastaRc',
      pattern = ':',
      callback = function(ctx)
        vim.keymap.set_table {
          mode = { 'n', 'x' },
          opts = { buffer = ctx.buf, nowait = true },
          maps = { { 'p', 'p' }, { 'P', 'P' } },
        }
      end,
    })
  end,
}

plugins['haya14busa/vim-edgemotion'] = {
  on_map = '<Plug>(edgemotion-',
  hook_add = function()
    vim.keymap.set_table {
      mode = { 'n', 'x', 'o' },
      maps = {
        { '<C-j>', '<Plug>(edgemotion-j)' },
        { '<C-k>', '<Plug>(edgemotion-k)' },
      },
    }
  end,
}

plugins['hrsh7th/vim-eft'] = {
  on_map = '<Plug>(eft-',
  hook_add = function()
    vim.keymap.set({ 'n', 'x', 'o' }, 'f', '<Plug>(eft-f)')
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', '<Plug>(eft-F)')

    vim.keymap.set({ 'x', 'o' }, 't', '<Plug>(eft-t)')
    vim.keymap.set({ 'x', 'o' }, 'T', '<Plug>(eft-T)')

    vim.keymap.set({ 'n', 'x', 'o' }, ';', '<Plug>(eft-repeat)')

    vim.g.eft_ignorecase = true
  end,
}

plugins['hrsh7th/vim-searchx'] = {
  on_map = '<Plug>(searchx-',
  hook_add = function()
    vim.keymap.set_table {
      mode = { 'n', 'x' },
      maps = {
        { '/', '<Plug>(searchx-start:forward)' },
        { '?', '<Plug>(searchx-start:backward)' },
        -- { 'n', '<Plug>(searchx-next-dir)' },
        -- { 'N', '<Plug>(searchx-prev-dir)' },
      },
    }
  end,
}

plugins['haya14busa/vim-asterisk'] = {
  on_map = '<Plug>(asterisk-',
  hook_add = function()
    vim.keymap.set_table {
      mode = { 'n', 'x', 'o' },
      maps = {
        { '*', '<Plug>(asterisk-z*)' },
        { '#', '<Plug>(asterisk-z#)' },
        { 'g*', '<Plug>(asterisk-gz*)' },
        { 'g#', '<Plug>(asterisk-gz#)' },
      },
    }
  end,
}

plugins['andymass/vim-matchup'] = {
  on_map = '<Plug>(matchup-%)',
  on_event = 'CursorMoved',
  hook_add = function()
    vim.g.loaded_matchit = 1
    vim.g.loaded_matchparen = 1
    vim.g.matchup_matchparen_offscreen = {
      method = 'status_manual',
    }

    vim.keymap.set({ 'n', 'x', 'o' }, '%', '<Plug>(matchup-%)')
  end,
  hook_post_source = function()
    vim.keymap.del('i', '<C-g>%')
  end,
}

plugins['lambdalisue/kensaku.vim'] = {
  on_cmd = 'Kensaku',
  on_func = 'kensaku#query',
}

plugins['machakann/vim-highlightedyank'] = {
  on_map = '<Plug>(highlightedyank)',
  hook_add = function()
    vim.keymap.set({ 'n', 'x', 'o' }, 'y', '<Plug>(highlightedyank)')
    vim.g.highlightedyank_highlight_duration = 200
  end,
}

plugins['tkmpypy/chowcho.nvim'] = {
  depends = 'nvim-web-devicons',
  on_lua = 'chowcho',
  hook_add = function()
    -- ORIGINAL: https://zenn.dev/kawarimidoll/articles/daa39da5838567

    -- <C-w>xと<C-w><C-x>を同時に設定する
    local win_keymap_set = function(key, callback)
      vim.keymap.set({ 'n' }, '<C-w>' .. key, callback)
      vim.keymap.set({ 'n' }, '<C-w><C-' .. key .. '>', callback)
    end

    win_keymap_set('w', function()
      local wins = 0

      -- 全ウィンドウをループ
      for i = 1, vim.fn.winnr '$' do
        local win_id = vim.fn.win_getid(i)
        local conf = vim.api.nvim_win_get_config(win_id)

        -- focusableなウィンドウをカウント
        if conf.focusable then
          wins = wins + 1

          -- ウィンドウ数が3以上ならchowchoを起動
          if wins > 2 then
            require('chowcho').run()
            return
          end
        end
      end

      -- ウィンドウが少なければ標準の<C-w><C-w>を実行
      vim.cmd.wincmd 'w'
    end)
  end,
}

---使うつもりはなくてhelpみたり更新追いたいリポジトリを参照するため
---@param watchList dein.Plugins
local function addWatchPlugins(watchList)
  watchList['hrsh7th/nvim-kit'] = {}
  watchList['junegunn/vim-plug'] = {}
  watchList['tani/vim-jetpack'] = {}
  watchList['wbthomason/packer.nvim'] = {}
  watchList['folke/lazy.nvim'] = {}

  watchList['Shougo/shougo-s-github'] = { name = 'Shougo' }
  watchList['thinca/config'] = { name = 'thinca' }
  watchList['monaqa/dotfiles'] = { name = 'monaqa' }
  watchList['kuuote/dotvim'] = { name = 'kuuote' }
  watchList['yutkat/dotfiles'] = { name = 'yutkat' }
  watchList['yuki-yano/dotfiles'] = { name = 'yuki-yano' }
  watchList['4513ECHO/dotfiles'] = { name = '4513ECHO' }
  watchList['kyoh86/dotfiles'] = { name = 'kyoh86' }
  watchList['rebelot/dotfiles'] = { name = 'rebelot' }
  watchList['stevearc/dotfiles'] = { name = 'stevearc' }
  watchList['lambdalisue/dotfiles'] = { name = 'lambdalisue' }
  watchList['L3MON4D3/Dotfiles'] = { name = 'L3MON4D3' }
  watchList['eihigh/dotfiles'] = { name = 'eihigh' }

  watchList['neovim/neovim'] = {
    path = ('%s/repos/github.com/neovim/neovim'):format(vim.env['HOME']),
    frozen = true,
  }
end

addWatchPlugins(plugins)

plugins['machakann/vim-sandwich'] = {
  on_map = { nx = '<Plug>(sandwich-', xo = '<Plug>(textobj-sandwich-' },
  hook_add = function()
    vim.g.sandwich_no_default_key_mappings = true

    vim.keymap.set_table {
      mode = { 'n', 'x' },
      maps = {
        { 's', '<Nop>' },
        { 'sa', '<Plug>(sandwich-add)' },
        { 'sd', '<Plug>(sandwich-delete)' },
        { 'sdb', '<Plug>(sandwich-delete-auto)' },
        { 'sr', '<Plug>(sandwich-replace)' },
        { 'srb', '<Plug>(sandwich-replace-auto)' },
      },
    }

    vim.keymap.set_table {
      mode = { 'o', 'x' },
      maps = {
        { 'ib', '<Plug>(textobj-sandwich-auto-i)' },
        { 'ab', '<Plug>(textobj-sandwich-auto-a)' },
      },
    }
  end,
}

plugins['kana/vim-textobj-user'] = {}

plugins['kana/vim-textobj-entire'] = {
  depends = 'vim-textobj-user',
  on_map = { xo = '<Plug>(textobj-entire-' },
  hook_add = function()
    vim.keymap.set_table {
      mode = { 'x', 'o' },
      maps = {
        { 'ie', '<Plug>(textobj-entire-i)' },
        { 'ae', '<Plug>(textobj-entire-a)' },
      },
    }
  end,
}

plugins['nvim-treesitter/nvim-treesitter'] = {
  on_event = { 'BufNewFile', 'BufReadPost' },
  hook_post_update = 'TSUpdate',
  plugin = {
    ['nvim-treesitter/nvim-treesitter-textobjects'] = {},
  },
}
plugins['kana/vim-operator-user'] = {}

plugins['kana/vim-operator-replace'] = {
  depends = 'vim-operator-user',
  on_map = { nx = '<Plug>(operator-replace)' },
  hook_add = function()
    vim.keymap.set({ 'n', 'x' }, 'r', '<Plug>(operator-replace)')
  end,
}

plugins['KentoOgata/caw.vim'] = {
  rev = 'fix/treesitter-hl_map-removed',
  depends = 'vim-operator-user',
  on_map = { nx = '<Plug>(caw:' },
  hook_add = function()
    vim.g.caw_no_default_keymappings = 1

    vim.keymap.set_table {
      mode = { 'n', 'x' },
      maps = {
        { 'gc', '<Plug>(caw:prefix)' },
        { '<Plug>(caw:prefix)i', '<Plug>(caw:hatpos:comment)' },
        { '<Plug>(caw:prefix)ui', '<Plug>(caw:hatpos:uncomment)' },
        { '<Plug>(caw:prefix)I', '<Plug>(caw:zeropos:comment)' },
        { '<Plug>(caw:prefix)uI', '<Plug>(caw:zeropos:uncomment)' },
        { '<Plug>(caw:prefix)a', '<Plug>(caw:dollarpos:comment)' },
        { '<Plug>(caw:prefix)ua', '<Plug>(caw:dollarpos:uncomment)' },
        { '<Plug>(caw:prefix)w', '<Plug>(caw:wrap:comment)' },
        { '<Plug>(caw:prefix)uw', '<Plug>(caw:wrap:uncomment)' },
        { '<Plug>(caw:prefix)b', '<Plug>(caw:box:comment)' },
        { '<Plug>(caw:prefix)o', '<Plug>(caw:jump:comment-next)' },
        { '<Plug>(caw:prefix)O', '<Plug>(caw:jump:comment-prev)' },
      },
    }

    vim.keymap.set('n', '<Plug>(caw:prefix)c', '<Plug>(caw:wrap:toggle:operator)')
    vim.keymap.set('x', '<Plug>(caw:prefix)c', '<Plug>(caw:hatpos:toggle)')
  end,
}

plugins['machakann/vim-swap'] = {
  on_map = { nxo = '<Plug>(swap-' },
  hook_add = function()
    vim.keymap.set('n', 'g<', '<Plug>(swap-prev)')
    vim.keymap.set('n', 'g>', '<Plug>(swap-next)')
    vim.keymap.set('n', 'gs', '<Plug>(swap-interactive)')
    vim.keymap.set({ 'x', 'o' }, 'is', '<Plug>(swap-textobject-i)')
    vim.keymap.set({ 'x', 'o' }, 'as', '<Plug>(swap-textobject-a)')
  end,
}

plugins['lambdalisue/glyph-palette.vim'] = {}

plugins['cohama/lexima.vim'] = {
  on_event = 'InsertEnter',
  hook_source = vim.fn['plugin_configurations#lexima'],
}

plugins['hrsh7th/nvim-insx'] = {
  on_event = 'InsertEnter',
}

plugins['mattn/emmet-vim'] = {
  on_map = { i = '<Plug>(emmet-' },
  hook_add = function()
    vim.keymap.set_table {
      mode = 'i',
      maps = {
        { '<C-y>,', '<Plug>(emmet-expand-abbr)' },
        { '<C-y>;', '<Plug>(emmet-expand-word)' },
        { '<C-y>u', '<Plug>(emmet-update-tag)' },
        { '<C-y>d', '<Plug>(emmet-balance-tag-inward)' },
        { '<C-y>D', '<Plug>(emmet-balance-tag-outward)' },
        { '<C-y>n', '<Plug>(emmet-move-next)' },
        { '<C-y>N', '<Plug>(emmet-move-prev)' },
        { '<C-y>i', '<Plug>(emmet-image-size)' },
        { '<C-y>/', '<Plug>(emmet-toggle-comment)' },
        { '<C-y>j', '<Plug>(emmet-split-join-tag)' },
        { '<C-y>k', '<Plug>(emmet-remove-tag)' },
        { '<C-y>a', '<Plug>(emmet-anchorize-url)' },
        { '<C-y>A', '<Plug>(emmet-anchorize-summary)' },
        { '<C-y>m', '<Plug>(emmet-merge-lines)' },
        { '<C-y>c', '<Plug>(emmet-code-pretty)' },
      },
    }
  end,
}

plugins['vim-skk/skkeleton'] = {
  depends = 'denops.vim',
  denops_wait = false,
  on_map = { ic = '<Plug>(skkeleton-toggle)' },
  hook_add = function()
    vim.keymap.set({ 'i', 'c' }, '<C-j>', '<Plug>(skkeleton-toggle)')
  end,
}

plugins['mattn/vim-sonictemplate'] = {
  merge_ftdetect = true,
  on_ft = 'stpl',
  on_cmd = 'Template',
  on_map = { i = { '<Plug>(sonictemplate-postfix)', '<Plug>(sonictemplate)' } },
  hook_add = function()
    local template_dir = ('%s/template/'):format(vim.fn.stdpath 'config')
    vim.g.sonictemplate_vim_template_dir = { template_dir }
  end,
  hook_source = function()
    -- sandbox内で初めてモジュールをvital#{}#import()すると:delfuncができなくてエラーになる
    vim.cmd.runtime 'autoload/dotnet.vim'
  end,
  ftplugin = {
    stpl = function()
      vim.bo.tabstop = 4
      vim.bo.expandtab = false
    end,
  },
}

plugins['SirVer/ultisnips'] = {}

plugins['hrsh7th/vim-vsnip'] = {
  hook_add = function()
    vim.g.vsnip_snippet_dir = ('%s/vsnip'):format(vim.fn.stdpath 'config')
    vim.g.vsnip_filetypes = {
      javascriptreact = { 'javascript' },
      typescriptreact = { 'typescript' },
    }
  end,
}

plugins['neoclide/coc.nvim'] = {
  enabled = vim.bool_fn.executable 'node',
  on_cmd = 'CocCommand',
  rev = 'release',
  hook_add = function()
    vim.g.coc_global_extensions = {
      'coc-fzf-preview',
    }
    vim.g.coc_data_home = ('%s/coc'):format(vim.fn.stdpath 'data')
    vim.autocmd.create('User', {
      group = vim.augroup.GetOrAdd 'VimRc',
      pattern = 'CocNvimInit',
      callback = function()
        vim.cmd.CocDisable()
      end,
    })
  end,
}

plugins['junegunn/fzf'] = {
  merged = false,
  build = 'go install',
}

plugins['junegunn/fzf.vim'] = {
  depends = 'fzf',
}

plugins['yuki-yano/fzf-preview.vim'] = {
  enabled = vim.bool_fn.executable 'node',
  rev = 'release/remote',
  depends = { 'fzf.vim', 'coc.nvim' },
  on_cmd = 'FzfPreview',
  hook_add = function()
    vim.api.nvim_create_user_command('MapFzfPreview', function()
      vim.keymap.set_table {
        mode = 'n',
        maps = {
          { '<Plug>(ff-file)', '<Cmd>FzfPreviewProjectFiles<CR>' },
          { '<Plug>(ff-oldfiles)', '<Cmd>FzfPreviewProjectOldFiles<CR>' },
          { '<Plug>(ff-word:cbuf)', '<Cmd>FzfPreviewLines<CR>' },
          { '<Plug>(ff-buffer)', '<Cmd>FzfPreviewBuffers<CR>' },
          { '<Plug>(ff-lsp-references)', '<Cmd>FzfPreviewNvimLspReferences<CR>' },
          {
            '<Plug>(ff-lsp-implementations)',
            function()
              vim.cmd.FzfPreviewNvimLspImplementation { vim.fn.expand '<cword>' }
            end,
          },
          {
            '<Plug>(ff-vimrc)',
            function()
              vim.cmd.FzfPreviewDirectoryFiles { ('%s/chezmoi'):format(vim.env.XDG_DATA_HOME) }
            end,
          },
        },
      }
    end, {})

    vim.keymap.set('n', '<space>af', '<Cmd>FzfPreviewGitActions<CR>')
  end,
}

plugins['ibhagwan/fzf-lua'] = {
  enabled = vim.bool_fn.executable 'fzf',
  depends = 'nvim-web-devicons',
  on_lua = 'fzf-lua',
  on_cmd = 'FzfLua',
  hook_add = function()
    vim.api.nvim_create_user_command('MapFzfLua', function()
      vim.keymap.set_table {
        mode = 'n',
        maps = {
          {
            '<Plug>(ff-file)',
            function()
              require('fzf-lua').files()
            end,
          },
          {
            '<Plug>(ff-vimrc)',
            function()
              require('fzf-lua').files {
                cwd = ('%s/chezmoi'):format(vim.env.XDG_DATA_HOME),
              }
            end,
          },
          {
            '<Plug>(ff-word:grep)',
            function()
              require('fzf-lua').grep()
            end,
          },
          {
            '<Plug>(ff-word:cbuf)',
            function()
              require('fzf-lua').blines()
            end,
          },
          {
            '<Plug>(ff-buffer)',
            function()
              require('fzf-lua').buffers()
            end,
          },
          {
            '<Plug>(ff-help)',
            function()
              require('fzf-lua').help_tags()
            end,
          },
          {
            '<Plug>(ff-lsp-typedefs)',
            function()
              require('fzf-lua').lsp_typedefs()
            end,
          },
          {
            '<Plug>(ff-lsp-references)',
            function()
              require('fzf-lua').lsp_references()
            end,
          },
          {
            '<Plug>(ff-lsp-implementations)',
            function()
              require('fzf-lua').lsp_implementations()
            end,
          },
          {
            '<Plug>(ff-resume)',
            function()
              require('fzf-lua').resume()
            end,
          },
          {
            '<Plug>(ff-command_history)',
            function()
              require('fzf-lua').command_history()
            end,
          },
          {
            '<Plug>(ff-git-status)',
            function()
              require('fzf-lua').git_status()
            end,
          },
          {
            '<Plug>(ff-lsp-workspace-symbols)',
            function()
              require('fzf-lua').lsp_workspace_symbols()
            end,
          },
          {
            '<Plug>(ff-oldfiles)',
            function()
              require('fzf-lua').oldfiles()
            end,
          },
        },
      }
    end, {})
  end,
}

plugins['nvim-telescope/telescope.nvim'] = {
  on_cmd = 'Telescope',
  on_lua = 'telescope',
  on_map = '<Plug>(telescope-',
  depends = { 'plenary.nvim', 'nvim-treesitter', 'nvim-web-devicons' },
  hook_add = function()
    vim.api.nvim_create_user_command('MapTelescope', function()
      vim.keymap.set_table {
        mode = 'n',
        maps = {
          { '<Plug>(ff-file)', '<Plug>(telescope-file)' },
          { '<Plug>(ff-word:grep)', '<Plug>(telescope-grep)' },
          { '<Plug>(ff-word:cbuf)', '<Plug>(telescope-current_buffer)' },
          { '<Plug>(ff-buffer)', '<Plug>(telescope-buffer)' },
          { '<Plug>(ff-help)', '<Plug>(telescope-help_tags)' },
          { '<Plug>(ff-resume)', '<Plug>(telescope-resume)' },
          { '<Plug>(ff-vimrc)', '<Plug>(telescope-vimrc)' },
          { '<Plug>(ff-git-status)', '<Plug>(telescope-git)' },
          { '<Plug>(ff-lsp-workspace-symbols)', '<Plug>(telescope-lsp_symbols)' },
          { '<Plug>(ff-lsp-references)', '<Plug>(telescope-lsp_references)' },
          { '<Plug>(ff-lsp-implementations)', '<Plug>(telescope-lsp_implementations)' },
          { '<Plug>(ff-command_history)', '<Plug>(telescope-command_history)' },
        },
      }
    end, {})
  end,
}

plugins['stevearc/aerial.nvim'] = {
  on_cmd = { 'AerialOpen', 'AerialToggle' },
  hook_add = function()
    vim.keymap.set('n', '<space>jj', '<Cmd>AerialToggle right<CR>')
  end,
}

plugins['thinca/vim-qfreplace'] = {
  on_cmd = 'Qfreplace',
}

plugins['itchyny/vim-qfedit'] = {
  on_ft = 'qf',
}

plugins['monaqa/dial.nvim'] = {
  on_map = { '<Plug>(dial-' },
  hook_add = function()
    vim.keymap.set_table {
      mode = { 'n', 'x' },
      maps = {
        { '<C-a>', '<Plug>(dial-increment)' },
        { '<C-x>', '<Plug>(dial-decrement)' },
      },
    }

    vim.keymap.set_table {
      mode = { 'x' },
      maps = {
        { 'g<C-a>', 'g<Plug>(dial-increment)' },
        { 'g<C-x>', 'g<Plug>(dial-decrement)' },
      },
    }
  end,
}

plugins['neovim/nvim-lspconfig'] = {
  on_event = 'FileType',
  plugin = {
    ['williamboman/mason-lspconfig.nvim'] = {
      depends = 'mason.nvim',
    },
    ['folke/neodev.nvim'] = {},
  },
}

plugins['williamboman/mason.nvim'] = {
  on_cmd = { 'Mason', 'MasonInstall' },
}

plugins['j-hui/fidget.nvim'] = {
  on_event = 'LspAttach',
}

plugins['folke/lsp-colors.nvim'] = {
  on_event = 'LspAttach',
}

plugins['jose-elias-alvarez/null-ls.nvim'] = {
  on_event = 'FileType',
  depends = 'plenary.nvim',
}

plugins['folke/trouble.nvim'] = {
  depends = 'nvim-web-devicons',
  on_cmd = 'TroubleToggle',
  on_lua = 'trouble',
  hook_add = function()
    vim.autocmd.create('LspAttach', {
      group = vim.augroup.GetOrAdd 'LspTroubleRc',
      callback = function(ctx)
        vim.keymap.set('n', '<space>jk', '<Cmd>TroubleToggle<CR>', { buffer = ctx.buf })
      end,
    })
  end,
}

plugins['zbirenbaum/neodim'] = {
  on_event = 'LspAttach',
}

plugins['SmiteshP/nvim-navic'] = {
  lazy = false,
  hook_add = function()
    vim.autocmd.create('LspAttach', {
      group = vim.augroup.GetOrAdd 'VimRc',
      callback = function(ctx)
        local client = vim.lsp.get_client_by_id(ctx.data.client_id)
        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, ctx.buf)
        end
      end,
    })
  end,
}

plugins['hrsh7th/nvim-cmp'] = {
  depends = { 'vim-vsnip', 'lspkind-nvim' },
  enabled = 'g:AutoCompletionEngine ==# "nvim-cmp"',
  on_event = { 'InsertEnter', 'CmdlineEnter' },
  plugin = {
    ['hrsh7th/cmp-nvim-lsp'] = {},
    ['hrsh7th/cmp-buffer'] = {},
    ['hrsh7th/cmp-path'] = {},
    ['hrsh7th/cmp-cmdline'] = {},
    ['hrsh7th/cmp-emoji'] = {},
    ['f3fora/cmp-spell'] = {},
    ['hrsh7th/cmp-vsnip'] = { depends = 'vim-vsnip' },
    ['uga-rosa/cmp-skkeleton'] = {
      -- depends = 'skkeleton',
      -- hook_source = function()
      --   vim.autocmd.create('User', {
      --     group = vim.augroup.create 'VimRc',
      --     pattern = 'skkeleton-enable-post',
      --     callback = function(ctx)
      --       vim.keymap.del('l', '<CR>', { buffer = ctx.buf })
      --     end,
      --   })
      -- end,
    },
  },
}

plugins['Shougo/ddc.vim'] = {
  lazy = false,
  hook_add = function()
    vim.autocmd.create({ 'InsertEnter', 'CmdlineEnter' }, {
      group = vim.augroup.GetOrAdd 'VimRc',
      once = true,
      callback = function()
        if vim.g.AutoCompletionEngine == 'ddc.vim' then
          vim.fn['ddc#custom#patch_global'] {
            ui = 'pum',
            sources = {
              'nvim-lsp',
              'file',
              'around',
            },
            cmdlineSources = {
              [':'] = { 'cmdline' },
              ['@'] = {},
              ['>'] = {},
              ['/'] = {},
              ['?'] = {},
              ['-'] = {},
              ['='] = { 'input' },
            },
            sourceOptions = {
              _ = {
                ignoreCase = true,
                minAutoCompleteLength = 1,
                matchers = { 'matcher_fuzzy' },
                sorters = { 'sorter_fuzzy' },
                converters = { 'converter_remove_overlap', 'converter_truncate_abbr', 'converter_fuzzy' },
              },
              around = {
                mark = 'A',
              },
              cmdline = {
                mark = 'vim',
                forceCompletionPattern = [[\S/\S*]],
              },
              ['nvim-lsp'] = {
                mark = 'lsp',
                forceCompletionPattern = [[\.\w*|:\w*|->\w*]],
                dup = 'force',
              },
              file = {
                mark = 'F',
                isVolatile = true,
                minAutoCompleteLength = 9999,
                forceCompletionPattern = [[\.{0,2}/(?:[/\-\_\w\.])*]],
              },
              input = {
                mark = 'input',
                forceCompletionPattern = [[\S/\S*]],
                isVolatile = true,
                dup = 'force',
              },
            },
            sourceParams = {
              ['nvim-lsp'] = {
                kindLabels = {
                  Class = 'c',
                },
              },
            },
            filterParams = {
              matcher_fuzzy = {
                splitMode = 'character',
              },
            },
            autoCompleteEvents = {
              'InsertEnter',
              'TextChangedI',
              'TextChangedP',
              'CmdlineChanged',
            },
          }
          if vim.g.AutoCompletionEngine == 'ddc.vim' then
            vim.fn['ddc#enable']()
          end
          vim.autocmd.create('CmdlineEnter', {
            group = vim.augroup.GetOrAdd 'VimRc',
            desc = 'Enable ddc cmdline completion on CmdlineEnter',
            callback = function()
              if vim.g.AutoCompletionEngine == 'ddc.vim' then
                vim.fn['ddc#enable_cmdline_completion']()
              end
            end,
          })
        else
          vim.autocmd.create('User', {
            group = vim.augroup.GetOrAdd 'VimRc',
            pattern = 'DenopsPluginPost:skkeleton',
            once = true,
            callback = function()
              vim.fn['ddc#custom#patch_global'] {
                ui = 'pum',
                sources = {
                  'skkeleton',
                },
                sourceOptions = {
                  skkeleton = {
                    mark = 'skk',
                    matchers = { 'skkeleton' },
                    sorters = {},
                    isVolatile = true,
                  },
                },
              }
              vim.fn['ddc#enable']()
            end,
          })
        end
      end,
    })
  end,
}

plugins['Shougo/ddc-ui-pum'] = { lazy = false }
plugins['Shougo/ddc-source-around'] = { lazy = false }
plugins['Shougo/ddc-source-cmdline'] = { lazy = false }
plugins['Shougo/ddc-source-nvim-lsp'] = { lazy = false }
plugins['LumaKernel/ddc-source-file'] = { lazy = false }
plugins['Shougo/ddc-input'] = { lazy = false }
plugins['Shougo/ddc-matcher_head'] = { lazy = false }
plugins['Shougo/ddc-sorter_rank'] = { lazy = false }
plugins['Shougo/ddc-converter_remove_overlap'] = { lazy = false }
plugins['Shougo/ddc-converter_truncate_abbr'] = { lazy = false }
plugins['tani/ddc-fuzzy'] = { lazy = false }

plugins['Shougo/pum.vim'] = {
  lazy = false,
  hook_add = function()
    vim.opt.completeopt:append 'noinsert'
    vim.autocmd.create('SourcePost', {
      pattern = 'pum.vim',
      group = vim.augroup.GetOrAdd 'VimRc',
      once = true,
      callback = function()
        vim.fn['pum#set_option'] {
          border = 'rounded',
        }
      end,
    })
  end,
}

plugins['lambdalisue/gina.vim'] = {
  on_cmd = 'Gina',
  on_func = 'gina#',
  hook_add = function()
    vim.keymap.set('n', '<Space>ah', '<Cmd>Gina log --graph --all --max-count=100<CR>')
    vim.keymap.set('n', '<Space>aH', function()
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
      vim.cmd.Gina { 'log', '--graph', '--max-count=100', bufname }
    end)
  end,
  hook_source = function()
    vim.fn['gina#custom#command#option']('commit', '-v|--verbose')
  end,
  ftplugin = {
    ['gina-commit'] = function()
      vim.wo.spell = true
    end,
  },
}

plugins['lambdalisue/gin.vim'] = {
  lazy = false,
  hook_add = function()
    vim.keymap.set('n', '<Space>aa', '<Cmd>GinStatus<CR>')
    vim.keymap.set('n', '<Space>ab', '<Cmd>GinBranch -av<CR>')
    vim.keymap.set('n', '<Space>ac', '<Cmd>Gin commit -v<CR>')
    vim.keymap.set('n', '<Space>aC', '<Cmd>Gin commit -v --amend<CR>')
    -- vim.keymap.set('n', '<Space>ah', '<Cmd>GinLog --graph --all --oneline<CR>')
    -- vim.keymap.set('n', '<Space>aH', function()
    --   local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
    --   vim.cmd.GinLog { '--graph', '--all', '--oneline', '--', bufname }
    -- end)

    vim.autocmd.create('BufReadCmd', {
      group = vim.augroup.GetOrAdd 'GinRc',
      pattern = 'ginedit://*',
      callback = function()
        vim.bo.buflisted = false
      end,
    })
  end,
  -- :buffer以外の方法で開かれたときも'buflisted'にはしない
  ftplugin = {
    ['gin-status'] = function(ctx)
      vim.autocmd.create('BufWinEnter', {
        buffer = ctx.buf,
        callback = function()
          vim.bo.buflisted = false
        end,
      })
    end,
    ['gin-diff'] = function(ctx)
      vim.autocmd.create('BufWinEnter', {
        buffer = ctx.buf,
        callback = function()
          vim.bo.buflisted = false
        end,
      })
    end,
    ['gin-branch'] = function(ctx)
      vim.autocmd.create('BufWinEnter', {
        buffer = ctx.buf,
        callback = function()
          vim.bo.buflisted = false
        end,
      })

      vim.keymap.set('n', 'N', '<Plug>(gin-action-new)', { buffer = ctx.buf })
    end,
    -- ['gin-log'] = function(ctx)
    --   vim.autocmd.create('BufWinEnter', {
    --     buffer = ctx.buf,
    --     callback = function()
    --       vim.bo[ctx.buf].buflisted = false
    --     end,
    --   })
    -- end,
  },
}

plugins['lewis6991/gitsigns.nvim'] = {
  on_event = 'BufReadPost',
  hook_add = function()
    vim.o.signcolumn = 'yes'
  end,
}

plugins['rhysd/committia.vim'] = {
  -- TODO: Gin commitで開いたときに使えるようにする
  --       現状でもGin commitで使えるが、commitした後のGinStatusの表示がおかしくなる
  --on_path = { 'COMMIT_EDITMSG', 'MERGE_MSG' },
  hook_add = function()
    vim.g.committia_hooks = {
      edit_open = function(_)
        vim.wo.spell = true
        vim.cmd [[setlocal spelllang+=cjk]]
      end,
    }

    vim.g.committia_open_only_vim_starting = 0
    vim.g.committia_use_singlecolumn = 'fallback'
    vim.g.committia_min_window_size = 160
    vim.g.committia_status_window_opencmd = 'belowright split'
    vim.g.committia_diff_window_opencmd = 'botright vsplit'
    vim.g.committia_singlecolumn_diff_window_opencmd = 'belowright split'
  end,
}

plugins['PhilT/vim-fsharp'] = {
  merge_ftdetect = true,
  on_ft = 'fsharp',
}

plugins['rust-lang/rust.vim'] = {
  merge_ftdetect = true,
  on_ft = 'rust',
}

plugins['vim-jp/syntax-vim-ex'] = {
  on_ft = 'vim',
}

plugins['nvim-orgmode/orgmode'] = {
  merge_ftdetect = true,
  on_ft = 'org',
  hook_post_update = function()
    if not vim.o.runtimepath:match '/nvim-treesitter' then
      require('dein').source 'nvim-treesitter'
    end
    require('orgmode').setup_ts_grammar()
    vim.cmd.TSUpdate()
  end,
}

plugins['jlcrochet/vim-razor'] = {
  merge_ftdetect = true,
  on_ft = 'razor',
}

plugins['itchyny/vim-haskell-indent'] = {
  on_ft = 'haskell',
}

plugins['chrisbra/csv.vim'] = {
  on_ft = 'csv',
  merge_ftdetect = true,
  hook_add = function()
    vim.g.csv_default_delim = ','
  end,
}

plugins['wgwoods/vim-systemd-syntax'] = {
  merge_ftdetect = true,
  on_ft = 'systemd',
}

plugins['alker0/chezmoi.vim'] = {
  lazy = false,
}

plugins['lambdalisue/fern.vim'] = {
  on_cmd = 'Fern',
  hook_add = function()
    vim.keymap.set('n', '<Plug>(filer)', function()
      if vim.bo[vim.api.nvim_get_current_buf()].buftype == '' then
        vim.cmd.Fern { '%:h', '-reveal=%' }
      else
        vim.cmd.Fern { '.' }
      end
    end)
    vim.keymap.set('n', '<Plug>(filer:drawer)', function()
      vim.cmd.Fern { '.', '-drawer', '-reveal=%' }
    end)
  end,
  ftplugin = {
    ['fern'] = function(au_ctx)
      local buflocal = {
        buffer = au_ctx.buf,
        nowait = true,
        silent = true,
      }
      vim.keymap.set_table {
        mode = 'n',
        opts = buflocal,
        maps = {
          { '<Space>', '<Plug>(fern-action-mark:toggle)' },
          { '<C-l>', '<Plug>(fern-action-reload:all)' },
          { 'h', '<Plug>(fern-action-collapse)' },
          { '<C-h>', '<Plug>(fern-action-leave)' },
          { '<Enter>', '<Plug>(fern-action-open)' },
          { 'y', '<Plug>(fern-action-yank:path)' },
          { '<C-c>', '<Plug>(fern-action-cancel)' },
          { 'N', '<Plug>(fern-action-new-file)' },
          { 'K', '<Plug>(fern-action-new-dir)' },
          { 'd', '<Plug>(fern-action-trash)' },
          { 'gr', '<Plug>(fern-action-grep)' },
          { 'r', '<Plug>(fern-action-rename)' },
        },
      }
      vim.cmd.nnoremap '<buffer><nowait><silent><expr> l fern#smart#leaf(\'<Plug>(fern-action-open)\', \'<Plug>(fern-action-expand)\')'

      vim.keymap.set('n', 'q', '<C-o>', buflocal)
    end,
  },
  plugin = {
    ['lambdalisue/fern-renderer-nerdfont.vim'] = {
      depends = { 'nerdfont.vim', 'glyph-palette.vim' },
      ftplugin = {
        fern = function()
          vim.fn['glyph_palette#apply']()
        end,
      },
    },
    ['yuki-yano/fern-preview.vim'] = {
      ftplugin = {
        fern = function(au_ctx)
          vim.keymap.set_table {
            mode = 'n',
            opts = {
              buffer = au_ctx.buf,
              nowait = true,
              silent = true,
            },
            maps = {
              { 'p', '<Plug>(fern-action-preview:toggle)' },
              { '<C-p>', '<Plug>(fern-action-preview:auto:toggle)' },
              { '<C-d>', '<Plug>(fern-action-preview:scroll:down:half)' },
              { '<C-u>', '<Plug>(fern-action-preview:scroll:up:half)' },
            },
          }
        end,
      },
    },
    ['lambdalisue/fern-git-status.vim'] = {},
  },
}

plugins['lambdalisue/fern-hijack.vim'] = {
  on_if = 'isdirectory(expand("<afile>"))',
  depends = 'fern.vim',
}

plugins['famiu/bufdelete.nvim'] = {
  on_cmd = { 'Bdelete', 'Bwipeout' },
  hook_add = function()
    vim.keymap.set('n', 'X', '<Cmd>Bdelete<CR>')
  end,
}

plugins['4513ECHO/vim-readme-viewer'] = {
  on_cmd = 'ReadmeOpen',
}

plugins['jremmen/vim-ripgrep'] = {
  enabled = vim.bool_fn.executable 'rg',
  on_cmd = 'Rg',
}

-- This plugin requires some os packages.
-- How to install:
-- $ sudo pacman -S pkgconf freetype2 fontconfig libxcb xclip
plugins['skanehira/denops-silicon.vim'] = {
  lazy = false,
}

plugins['jbyuki/venn.nvim'] = {
  repo = 'jbyuki/venn.nvim',
  on_cmd = { 'Venn', 'VBox' },
  hook_add = function()
    vim.o.virtualedit = 'block'
    vim.keymap.set('x', [[<Space>f]], ':VBox<CR>')
  end,
}

plugins['thinca/vim-themis'] = {
  hook_add = function()
    vim.env.THEMIS_VIM = 'nvim'
    vim.env.THEMIS_HOME = vim.env.DEIN_BASE .. '/repos/github.com/thinca/vim-themis'
    vim.env.PATH = vim.env.PATH .. ':' .. vim.env.THEMIS_HOME .. '/bin'
  end,
}

plugins['uga-rosa/ccc.nvim'] = {
  on_cmd = { 'CccPick', 'CccHighlighterEnable' },
  on_map = { i = '<Plug>(ccc-insert)' },
  on_event = 'LspAttach',
  hook_add = function()
    vim.keymap.set('i', '<C-v>c', '<Plug>(ccc-insert)')
  end,
  hook_post_source = function()
    vim.cmd.CccHighlighterEnable()
  end,
}

plugins['vim-jp/vital.vim'] = {
  on_cmd = 'Vitalize',
  on_func = 'vital#vital#',
}

plugins['Eandrju/cellular-automaton.nvim'] = {
  on_cmd = 'CellularAutomaton',
}

plugins['tweekmonster/helpful.vim'] = {
  on_cmd = 'HelpfulVersion',
}

plugins['tyru/capture.vim'] = {
  on_cmd = 'Capture',
}

plugins['rcarriga/nvim-notify'] = {
  depends = 'plenary.nvim',
  on_event = { 'CursorHold', 'CursorMoved', 'CmdlineEnter', 'FileType' },
}

plugins['levouh/tint.nvim'] = {
  on_event = 'WinLeave',
}

plugins['lukas-reineke/indent-blankline.nvim'] = {
  on_event = { 'BufNewFile', 'BufReadPost' },
  hook_add = function()
    vim.g.indentLine_fileTypeExclude = {
      'lspinfo',
      'packer',
      'checkhealth',
      'help',
      'man',
      '',
      'fern',
    }
  end,
}

plugins['gen740/SmoothCursor.nvim'] = {
  on_event = 'CursorMoved',
  hook_add = function()
    vim.o.signcolumn = 'yes'
    if 'dark' == vim.o.background then
      vim.o.cursorline = false
    end
  end,
}

plugins['stevearc/dressing.nvim'] = {
  depends = 'nui.nvim',
  on_event = 'CursorMoved',
}

plugins['Shougo/dein.vim'] = {
  repo = 'Shougo/dein.vim',
  lazy = false,
}

plugins['vim-jp/vimdoc-ja'] = {
  lazy = false,
  merged = false,
  hook_add = function()
    vim.o.helplang = 'ja,en'
  end,
}

---@return string path deno executable file's path
local function installDeno()
  local path = vim.fs.normalize '~/.deno/bin/deno'
  if not vim.bool_fn.filereadable(path) then
    os.execute 'curl -fsSL https://deno.land/x/install/install.sh | bash'
  end
  return path
end

plugins['vim-denops/denops.vim'] = {
  lazy = false,
  hook_add = function()
    if not vim.bool_fn.executable 'deno' then
      vim.g['denops#deno'] = installDeno()
    end
  end,
}

plugins['nvim-lua/plenary.nvim'] = {}

plugins['MunifTanjim/nui.nvim'] = {}

plugins['nvim-tree/nvim-web-devicons'] = {}

plugins['onsails/lspkind-nvim'] = {}

plugins['lambdalisue/nerdfont.vim'] = {
  lazy = false,
}

plugins['rebelot/heirline.nvim'] = {
  depends = 'nvim-web-devicons',
  on_event = { 'FileType', 'WinNew' },
}

plugins['tiagovla/scope.nvim'] = {
  lazy = false,
  hook_add = function()
    vim.autocmd.create('CmdlineEnter', {
      once = true,
      group = vim.augroup.GetOrAdd 'VimRc',
      desc = 'Setup scope.nvim',
      callback = function()
        require('scope').setup()
      end,
    })
  end,
}

plugins['yuki-yano/ai-review.nvim'] = {
  depends = { 'denops.vim', 'nui.nvim' },
  on_cmd = 'AiReview',
}

plugins = vim.tbl_extend('error', plugins, require 'rc.ddu-vim', require 'rc.colorscheme-plugins')

require('dein_').startup(plugins)
