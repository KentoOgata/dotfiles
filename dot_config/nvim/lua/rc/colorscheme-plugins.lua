---@type dein.Plugins
local plugins = {}

--- @param options table
local function pick(options)
  return options[math.random(#options)]
end

--- @type table
local themes = {}

vim.api.nvim_create_user_command('RandomTheme', function()
  vim.cmd('colorscheme ' .. pick(themes))
end, {})

plugins['rebelot/kanagawa.nvim'] = {
  lazy = false,
  hook_add = function()
    vim.autocmd.create('ColorSchemePre', {
      pattern = 'kanagawa',
      callback = function()
        vim.o.background = 'dark'
        require('kanagawa').setup {
          commentStyle = { italic = false },
          keywordStyle = { italic = false },
          variablebuiltinStyle = { italic = false },
        }
      end,
    })

    table.insert(themes, 'kanagawa')
  end,
}

plugins['cocopon/iceberg.vim'] = {
  lazy = false,
  hook_add = function()
    vim.autocmd.create('ColorSchemePre', {
      pattern = 'iceberg',
      callback = function()
        vim.o.background = pick { 'dark', 'light' }
      end,
    })

    table.insert(themes, 'iceberg')
  end,
}

plugins['sainnhe/gruvbox-material'] = {
  lazy = false,
  merged = false,
  hook_add = function()
    vim.autocmd.create('ColorSchemePre', {
      pattern = 'gruvbox-material',
      callback = function()
        vim.o.background = 'dark'

        vim.g.gruvbox_material_background = pick { 'hard', 'medium', 'soft' }
        vim.g.gruvbox_material_foreground = pick { 'material', 'mix', 'original' }
        vim.g.gruvbox_material_disable_italic_comment = 1
        vim.g.gruvbox_material_enable_bold = 0
        vim.g.gruvbox_material_enable_italic = 0
        vim.g.gruvbox_material_cursor = 'auto'
        vim.g.gruvbox_material_transparent_background = 0
        vim.g.gruvbox_material_visual = 'grey background'
        vim.g.gruvbox_material_menu_selection_background = 'grey'
        vim.g.gruvbox_material_sign_column_background = 'none'
        vim.g.gruvbox_material_spell_foreground = 'colored'
        vim.g.gruvbox_material_ui_contrast = pick { 'low', 'high' }
        vim.g.gruvbox_material_show_eob = 1
        vim.g.gruvbox_material_diagnostic_text_highlight = 1
        vim.g.gruvbox_material_diagnostic_line_highlight = 1
        vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
        vim.g.gruvbox_material_current_word = 'grey background'
        vim.g.gruvbox_material_disable_terminal_colors = 0
        vim.g.gruvbox_material_statusline_style = pick { 'default', 'mix', 'original' }
        vim.g.gruvbox_material_better_performance = 1
        --      vim.g.gruvbox_material_colors_override = {}
      end,
    })

    table.insert(themes, 'gruvbox-material')
  end,
}

plugins['sainnhe/edge'] = {
  lazy = false,
  merged = false,
  hook_add = function()
    vim.autocmd.create('ColorSchemePre', {
      pattern = 'edge',
      callback = function()
        vim.o.background = 'dark'

        vim.g.edge_style = pick { 'default', 'aura', 'neon' }
        vim.g.edge_dim_foreground = 0
        vim.g.edge_disable_italic_comment = 1
        vim.g.edge_enable_italic = 0
        vim.g.edge_cursor = 'auto'
        vim.g.edge_transparent_background = 0
        vim.g.edge_menu_selection_background = 'blue'
        vim.g.edge_spell_foreground = 'none'
        vim.g.edge_show_eob = 1
        vim.g.edge_diagnostic_text_highlight = 1
        vim.g.edge_diagnostic_line_highlight = 1
        vim.g.edge_diagnostic_virtual_text = 'colored'
        vim.g.edge_current_word = 'grey background'
        vim.g.edge_disable_terminal_colors = 0
        vim.g.edge_better_performance = 1
        --    vim.g.edge_colors_override = {}
      end,
    })

    table.insert(themes, 'edge')
  end,
}

plugins['sainnhe/everforest'] = {
  lazy = false,
  merged = false,
  hook_add = function()
    vim.autocmd.create('ColorSchemePre', {
      pattern = 'everforest',
      callback = function()
        vim.o.background = pick { 'dark', 'light' }

        vim.g.everforest_background = pick { 'hard', 'medium', 'soft' }
        vim.g.everforest_enable_italic = 0
        vim.g.everforest_disable_italic_comment = 1
        vim.g.everforest_cursor = 'auto'
        vim.g.everforest_transparent_background = 0
        vim.g.everforest_sign_column_background = 'none'
        vim.g.everforest_spell_foreground = 'none'
        vim.g.everforest_ui_contrast = pick { 'low', 'high' }
        vim.g.everforest_show_eob = 1
        vim.g.everforest_diagnostic_text_highlight = 1
        vim.g.everforest_diagnostic_line_highlight = 0
        vim.g.everforest_diagnostic_virtual_text = 'colored'
        vim.g.everforest_current_word = 'grey background'
        vim.g.everforest_disable_terminal_colors = 0
        vim.g.everforest_better_performance = 1
        --    vim.g.everforest_colors_override = {}
      end,
    })

    table.insert(themes, 'everforest')
  end,
}

plugins['sainnhe/sonokai'] = {
  lazy = false,
  merged = false,
  hook_add = function()
    vim.autocmd.create('ColorSchemePre', {
      pattern = 'sonokai',
      callback = function()
        vim.o.background = 'dark'

        vim.g.sonokai_style = pick { 'default', 'atlantis', 'andromeda', 'shusia', 'maia', 'espresso' }
        vim.g.sonokai_disable_italic_comment = 1
        vim.g.sonokai_enable_italic = 0
        vim.g.sonokai_cursor = 'auto'
        vim.g.sonokai_transparent_background = 0
        vim.g.sonokai_menu_selection_background = 'blue'
        vim.g.sonokai_spell_foreground = 'none'
        vim.g.sonokai_show_eob = 1
        vim.g.sonokai_diagnostic_text_highlight = 1
        vim.g.sonokai_diagnostic_line_highlight = 1
        vim.g.sonokai_diagnostic_virtual_text = 'colored'
        vim.g.sonokai_current_word = 'grey background'
        vim.g.sonokai_disable_terminal_colors = 0
        vim.g.sonokai_better_performance = 1
        --    vim.g.sonokai_colors_override = {}
      end,
    })

    table.insert(themes, 'sonokai')
  end,
}

plugins['EdenEast/nightfox.nvim'] = {
  lazy = false,
  hook_add = function()
    table.insert(themes, 'nightfox')
    table.insert(themes, 'duskfox')
    table.insert(themes, 'dawnfox')
    table.insert(themes, 'nordfox')
    table.insert(themes, 'dayfox')
    table.insert(themes, 'terafox')
    table.insert(themes, 'carbonfox')
  end,
}

plugins['folke/tokyonight.nvim'] = {
  lazy = false,
  hook_add = function()
    table.insert(themes, 'tokyonight-night')

    vim.autocmd.create('ColorSchemePre', {
      pattern = 'tokyonight-night',
      callback = function()
        require('tokyonight').setup {
          styles = {
            comments = { italic = false },
            keywords = { italic = false },
          },
        }
      end,
    })
  end,
}

plugins['YorickPeterse/vim-paper'] = {
  lazy = false,
  hook_add = function()
    table.insert(themes, 'paper')
  end,
}

plugins['shaunsingh/nord.nvim'] = {
  lazy = false,
  hook_add = function()
    vim.g.nord_italic = false
    table.insert(themes, 'nord')
  end,
}

plugins['Julpikar/night-owl.nvim'] = {
  lazy = false,
  hook_add = function()
    table.insert(themes, 'night-owl')
  end,
}

plugins['catppuccin/nvim'] = {
  lazy = false,
  name = 'catppuccin',
  hook_add = function()
    table.insert(themes, 'catppuccin-latte')
    table.insert(themes, 'catppuccin-frappe')
    table.insert(themes, 'catppuccin-macchiato')
    table.insert(themes, 'catppuccin-mocha')

    vim.autocmd.create('ColorSchemePre', {
      pattern = 'catppuccin-*',
      callback = function(ctx)
        require('catppuccin').setup {
          no_italic = true,
          integrations = {
            aerial = true,
            bufferline = true,
            cmp = true,
            coc_nvim = true,
            fern = true,
            fidget = true,
            gitsigns = true,
            indent_blankline = {
              colored_indent_levels = true,
            },
            lsp_trouble = true,
            markdown = true,
            mason = true,
            noice = true,
            neotree = true,
            notify = true,
            sandwich = true,
            semantic_tokens = true,
            telekasten = true,
            telescope = true,
            treesitter = true,
            treesitter_context = true,
            ts_rainbow = true,
          },
        }

        local flavor = ctx.match:sub(('catppuccin-'):len() + 1)
        local p = require(('catppuccin.palettes.%s'):format(flavor))

        vim.env['FZF_DEFAULT_OPTS'] = ([[
            --color=bg+:%s,bg:%s,spinner:%s,hl:%s
            --color=fg:%s,header:%s,info:%s,pointer:%s
            --color=marker:%s,fg+:%s,prompt:%s,hl+:%s
          ]]):format(
          p.surface0,
          p.base,
          p.rosewater,
          p.red,
          p.text,
          p.red,
          p.mauve,
          p.rosewater,
          p.rosewater,
          p.text,
          p.mauve,
          p.red
        )

        vim.env['BAT_THEME'] = ('Catppuccin-%s'):format(flavor)
      end,
    })
  end,
}

plugins['machakann/vim-colorscheme-snowtrek'] = {
  lazy = false,
  hook_add = function()
    table.insert(themes, 'snowtrek')
  end,
}

plugins['eihigh/vim-aomi-grayscale'] = {
  lazy = false,
  hook_add = function()
    table.insert(themes, 'aomi-grayscale')
  end,
}

plugins['marko-cerovac/material.nvim'] = {
  lazy = false,
  hook_add = function()
    table.insert(themes, 'material')
  end,
}

plugins['rose-pine/neovim'] = {
  name = 'rose-pine',
  lazy = false,
  hook_add = function()
    vim.autocmd.create('ColorSchemePre', {
      pattern = 'rose-pine',
      group = vim.augroup.GetOrAdd 'VimRc',
      callback = function()
        vim.o.background = pick { 'dark', 'light' }
        require('rose-pine').setup {
          --- @usage 'auto'|'main'|'moon'|'dawn'
          variant = 'auto',
          --- @usage 'main'|'moon'|'dawn'
          dark_variant = 'main',
          bold_vert_split = false,
          dim_nc_background = false,
          disable_background = false,
          disable_float_background = false,
          disable_italics = false,

          --- @usage string hex value or named color from rosepinetheme.com/palette
          groups = {
            background = 'base',
            background_nc = '_experimental_nc',
            panel = 'surface',
            panel_nc = 'base',
            border = 'highlight_med',
            comment = 'muted',
            link = 'iris',
            punctuation = 'subtle',

            error = 'love',
            hint = 'iris',
            info = 'foam',
            warn = 'gold',

            headings = {
              h1 = 'iris',
              h2 = 'foam',
              h3 = 'rose',
              h4 = 'gold',
              h5 = 'pine',
              h6 = 'foam',
            },
            -- or set all headings at once
            -- headings = 'subtle'
          },

          -- Change specific vim highlight groups
          -- https://github.com/rose-pine/neovim/wiki/Recipes
          highlight_groups = {
            ColorColumn = { bg = 'rose' },

            -- Blend colours against the "base" background
            CursorLine = { bg = 'foam', blend = 10 },
            StatusLine = { fg = 'love', bg = 'love', blend = 10 },
          },
        }
      end,
    })
    table.insert(themes, 'rose-pine')
  end,
}

return plugins
