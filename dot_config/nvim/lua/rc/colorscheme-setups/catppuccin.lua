return {
  setup = function()
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

    local flavor = vim.fn.expand('<amatch>'):sub(('catppuccin-'):len() + 1)
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
}
