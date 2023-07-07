-- lua_source {{{
local cmp = require 'cmp'

---@param keys string
---@param flags nil|string
local function feedkeys(keys, flags)
  vim.fn.feedkeys(vim.keycode(keys), flags or 'nt')
end

local function getCurrentDisplayedBuffers()
  local bufs = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if not (vim.api.nvim_get_option_value('buftype', { buf = buf }) == 'terminal') then
      table.insert(bufs, buf)
    end
  end
  return bufs
end

cmp.setup {
  enabled = function()
    -- プロンプトバッファでは無効
    return vim.bo.buftype ~= 'prompt'
  end,
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },
  window = {
    completion = {
      border = 'rounded',
    },
    documentation = {
      border = 'rounded',
    },
  },
  preselect = cmp.PreselectMode.None,
  experimental = {
    ghost_text = {
      hl_group = 'Comment',
    },
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = require('lspkind').cmp_format {
      mode = 'symbol',
      preset = 'codicons',
      menu = {
        luasnip = '[Snippet]',
        tsnip = '[TSnip]',
        copilot = '[Copilot]',
        nvim_lsp = '[LSP]',
        treesitter = '[Tree]',
        nvim_lua = '[Lua]',
        cmp_tabnine = '[Tabnine]',
        buffer = '[Buffer]',
        tmux = '[Tmux]',
        rg = '[Rg]',
        look = '[Look]',
        path = '[Path]',
      },
    },
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    {
      name = 'buffer',
      option = {
        get_bufnrs = getCurrentDisplayedBuffers,
      },
    },
    { name = 'spell' },
    -- { name = 'skkeleton' },
  },
  mapping = {
    ['<CR>'] = function(fallback)
      if cmp.visible() then
        cmp.confirm {
          select = true,
          behavior = cmp.ConfirmBehavior.Replace,
        }
      elseif vim.fn['pum#visible']() then
        vim.fn['pum#map#confirm']()
      else
        fallback()
      end
    end,
    ['<C-n>'] = function()
      if cmp.visible() then
        cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
      elseif vim.fn['pum#visible']() then
        vim.fn['pum#map#insert_relative'](1)
      elseif 1 == vim.fn.pumvisible() then
        feedkeys '<C-n>'
      end
      cmp.complete()
    end,
    ['<C-p>'] = function()
      if cmp.visible() then
        cmp.select_prev_item { behavior = cmp.SelectBehavior.Insert }
      elseif vim.fn['pum#visible']() then
        vim.fn['pum#map#insert_relative'](-1)
      elseif 1 == vim.fn.pumvisible() then
        feedkeys '<C-p>'
      end
      cmp.complete()
    end,
    ['<C-g>'] = function(fallback)
      if cmp.visible() then
        cmp.abort()
      elseif vim.fn['pum#visible']() then
        vim.fn['pum#map#cancel']()
      else
        fallback()
      end
    end,
    ['<Tab>'] = function(fallback)
      if vim.fn['vsnip#jumpable'](1) == 1 then
        feedkeys '<Plug>(vsnip-jump-next)'
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn['vsnip#jumpable'](-1) == 1 then
        feedkeys '<Plug>(vsnip-jump-prev)'
      else
        fallback()
      end
    end,
  },
}
cmp.setup.cmdline(':', {
  enabled = true,
  mapping = {
    ['<Tab>'] = {
      c = function()
        if cmp.visible() then
          cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
        elseif vim.fn['pum#visible']() then
          vim.fn['pum#map#insert_relative'](1)
        else
          feedkeys '<Tab>'
        end
      end,
    },
    ['<S-Tab>'] = {
      c = function()
        if cmp.visible() then
          cmp.select_prev_item { behavior = cmp.SelectBehavior.Insert }
        elseif vim.fn['pum#visible']() then
          vim.fn['pum#map#insert_relative'](-1)
        else
          feedkeys '<S-Tab>'
        end
      end,
    },
    ['<C-g>'] = {
      c = function(fallback)
        if cmp.visible() then
          cmp.close()
        elseif vim.fn['pum#visible']() then
          vim.fn['pum#map#cancel']()
        else
          fallback()
        end
      end,
    },
    ['<C-f>'] = {
      c = function()
        if cmp.visible() then
          cmp.close()
        elseif vim.fn['pum#visible']() then
          vim.fn['pum#map#cancel']()
        end
        feedkeys '<C-f>'
      end,
    },
  },
  sources = cmp.config.sources {
    { name = 'path' },
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { '!' },
      },
    },
  },
})
cmp.setup.filetype('gitcommit', {
  sources = require('cmp').config.sources({
    { name = 'emoji' },
  }, {
    {
      name = 'buffer',
      option = {
        get_bufnrs = getCurrentDisplayedBuffers,
      },
    },
  }),
})
cmp.setup.filetype('ddu-ff-filter', {
  sources = {},
})
cmp.setup.filetype('TelescopePrompt', {
  enabled = false,
})
vim.api.nvim_create_autocmd('User', {
  pattern = 'skkeleton-disable-post',
  callback = function()
    require('cmp').setup.buffer { enabled = true }
  end,
})
vim.api.nvim_create_autocmd('User', {
  pattern = 'skkeleton-enable-post',
  callback = function()
    require('cmp').setup.buffer { enabled = false }
  end,
})

local snippetTrigger = '<Plug>(expand-bracket)'

local function addLeximaRules()
  local rules = {
    { except = [[\%#(]], input = '(', input_after = ')' },
    { input = '', priority = -1 },
    { filetype = 'haskell', input = '' },
  }
  for _, rule in ipairs(rules) do
    vim.fn['lexima#add_rule'](vim.tbl_deep_extend('error', rule, { char = snippetTrigger }))
  end
end

--[[
if nil ~= vim.go.rtp:match 'lexima.vim' then
  addLeximaRules()
else
  vim.api.nvim_create_autocmd('SourcePost', {
    once = true,
    group = 'VimRc',
    pattern = 'lexima.vim',
    callback = addLeximaRules,
  })
end
--]]
-- NOTE: なぜか実行しても問題ない
addLeximaRules()

local leximaExpand = require('rc.utils').leximaExpand

cmp.event:on('confirm_done', function(event)
  local function is_function_symbol(item)
    local kind = cmp.lsp.CompletionItemKind
    return (item.kind == kind.Method) or (item.kind == kind.Function) or (item.kind == kind.Constructor)
  end
  local item = event.entry:get_completion_item()
  if is_function_symbol(item) then
    feedkeys(leximaExpand('i', snippetTrigger))
  end
end)
--- }}}
