return {
  setup = function()
    vim.keymap.set('n', 'K', '<Nop>')

    vim.keymap.set('n', '<A-,>', '<Cmd>edit $MYVIMRC<CR>')

    vim.keymap.set('n', '<space>q', '<Cmd>vs<CR>')

    local function with_indent_when_empty(insert_command)
      return function()
        if vim.wo.virtualedit == 'all' then
          return insert_command
        end

        if string.len(vim.fn.getline '.') == 0 then
          return '"_cc'
        else
          return insert_command
        end
      end
    end

    vim.keymap.set_table {
      mode = 'n',
      maps = {
        { 'i', with_indent_when_empty 'i', { expr = true } },
        { 'a', with_indent_when_empty 'a', { expr = true } },
        { ']t', '<Cmd>tabn<CR>' },
        { '[t', '<Cmd>tabN<CR>' },
        { 't', '<Nop>' },
      },
    }

    vim.autocmd.create('InsertEnter', {
      once = true,
      group = vim.augroup.GetOrAdd 'InsertMaps',
      callback = function()
        vim.keymap.set('i', '<Plug>(input-char-by-code)', '<C-r>=nr2char(eval(input("char? ", "0x")))<CR>')
        vim.keymap.set('i', '<C-v>u', '<Plug>(input-char-by-code)')

        vim.keymap.set('i', '<C-a>', '<Home>')
        vim.keymap.set('i', '<C-e>', '<End>')
        vim.keymap.set('i', '<C-f>', '<C-g>U<Right>')
        vim.keymap.set('i', '<C-b>', '<C-g>U<Left>')
      end,
    })

    vim.keymap.set('n', '<C-l>', function()
      vim.cmd.nohlsearch()
      vim.cmd.diffupdate()
      vim.cmd.normal { args = { '<C-l>' }, bang = true }
    end)

    vim.keymap.set_table {
      mode = 'n',
      maps = {
        { '<Space>ff', '<Plug>(ff-file)' },
        { '<Space>fz', '<Plug>(ff-oldfiles)' },
        { '<Space>fw', '<Plug>(ff-word:grep)' },
        { '<Space>fs', '<Plug>(ff-word:cbuf)' },
        { '<Space>fb', '<Plug>(ff-buffer)' },
        { '<Space>fh', '<Plug>(ff-help)' },
        { '<Space>fn', '<Plug>(ff-resume)' },
        { '<Space>fc', '<Plug>(ff-vimrc)' },
        { '<Space>fa', '<Plug>(ff-git-status)' },
        { '<Space>fo', '<Plug>(ff-command_history)' },
        { '<Space>e', '<Plug>(filer)' },
        { '<C-w>e', '<Plug>(filer:drawer)' },
        { '<Space><Space>e', '<Plug>(filer:git-status)' },
      },
    }
  end,
}
