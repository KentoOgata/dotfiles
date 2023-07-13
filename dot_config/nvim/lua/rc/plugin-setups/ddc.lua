---@class ddc.Source
---@field name string
---@field params? table
---@field options? ddc.SourceOption[]

---@class ddc.SourceOption
---@field converters? string[]
---@field dup "force"|"keep"|"ignore"
---@field enabledIf? string a text to evaluated as vim expression.
---@field forceCompletionPattern? string
---@field keywordPattern? string
---@field ignoreCase? boolean
---@field isVolatile? boolean
---@field mark? string
---@field maxAutoCompleteLength? number
---@field maxItems? number
---@field matcherKey? string
---@field matchers? string[]
---@field maxKeywordLength? number
---@field minAutoCompleteLength? number
---@field minKeywordLength? number
---@field sorters? string[]
---@field timeout? number

---@class ddc.Config
---@field autoCompleteDelay? number
---@field autoCompleteEvents? string[]
---@field backspaceCompletion? boolean
---@field cmdlineSources? { [":"|"@"|">"|"/"|"?"|"-"|"="]: string[]|ddc.SourceOption[] }
---@field ui string
---@field sources ddc.Source[]

vim.api.nvim_create_autocmd({ 'InsertEnter', 'CmdlineEnter' }, {
  group = 'VimRc',
  once = true,
  callback = function()
    if vim.g.did_ddc_setup then
      return
    end
    vim.g.did_ddc_setup = true

    ---@type ddc.Config
    local config = {
      ui = 'native',
      -- ui = 'pum',
      sources = {
        {
          name = 'nvim-lsp',
          params = {
            snippetEngine = vim.fn['denops#callback#register'](function(body)
              vim.fn['vsnip#anonymous'](body)
            end),
            enableResolveItem = true,
            enableAdditionalTextEdit = true,
            confirmBehavior = 'replace',
          },
          options = {
            mark = '[LS]',
            matchers = { 'matcher_fuzzy' },
            sorters = { 'sorter_fuzzy' },
            converters = { 'converter_fuzzy', 'converter_kind_labels' },
            ignoreCase = true,
            forceCompletionPattern = [[\.]],
            minAutoCompleteLength = 1,
          },
        },
        {
          name = 'skkeleton',
          options = {
            mark = '[SKK]',
            matchers = { 'skkeleton' },
            sorters = {},
            isVolatile = true,
          },
        },
        {
          name = 'buffer',
          options = {
            mark = '[Buffer]',
            matchers = { 'matcher_fuzzy' },
            sorters = { 'sorter_fuzzy' },
            converters = { 'converter_fuzzy' },
          },
          params = {
            fromAltBuf = true,
          },
        },
      },
      autoCompleteEvents = {
        'InsertEnter',
        'TextChangedI',
        'TextChangedP',
        'CmdlineEnter',
        'CmdlineChanged',
      },
      backspaceCompletion = true,
      cmdlineSources = {
        [':'] = {
          {
            name = 'cmdline',
            options = {
              matchers = { 'matcher_fuzzy' },
              sorters = { 'sorter_fuzzy' },
              converters = { 'converter_fuzzy' },
            },
          },
        },
      },
    }
    vim.fn['ddc#custom#patch_global'](config)
    vim.fn['ddc#custom#patch_filetype']('vim', 'sources', {
      {
        name = 'necovim',
        options = {
          mark = '[Vim]',
          matchers = { 'matcher_fuzzy' },
          sorters = { 'sorter_fuzzy' },
          converters = { 'converter_fuzzy' },
        },
      },
    })
    vim.fn['ddc#enable']()
  end,
})

vim.api.nvim_create_autocmd('CmdlineEnter', {
  group = 'VimRc',
  desc = 'call ddc#enable_cmdline_completion()',
  callback = function()
    vim.fn['ddc#enable_cmdline_completion']()
  end,
})
