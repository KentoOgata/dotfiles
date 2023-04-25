require('gtd').setup {}

vim.keymap.set_table {
  mode = 'n',
  maps = {
    {
      '<Plug>(gtd:edit)',
      function()
        require('gtd').exec { command = 'edit' }
      end,
    },
    {
      '<Plug>(gtd:splitleft)',
      function()
        local splitright = vim.go.splitright
        vim.go.splitright = false
        require('gtd').exec({
          command = 'vsplit',
        }, {
          on_event = function(event)
            if event == require('gtd').Event.Finish then
              vim.go.splitright = splitright
            end
          end,
        })
      end,
    },
    {
      '<Plug>(gtd:splitbelow)',
      function()
        local splitbelow = vim.go.splitbelow
        vim.go.splitbelow = true
        require('gtd').exec({
          command = 'split',
        }, {
          on_event = function(event)
            if event == require('gtd').Event.Finish then
              vim.go.splitbelow = splitbelow
            end
          end,
        })
      end,
    },
    {
      '<Plug>(gtd:splitabove)',
      function()
        local splitbelow = vim.go.splitbelow
        vim.go.splitbelow = false
        require('gtd').exec({
          command = 'split',
        }, {
          on_event = function(event)
            if event == require('gtd').Event.Finish then
              vim.go.splitbelow = splitbelow
            end
          end,
        })
      end,
    },
    {
      '<Plug>(gtd:splitright)',
      function()
        local splitright = vim.go.splitright
        vim.go.splitright = true
        require('gtd').exec({
          command = 'vsplit',
        }, {
          on_event = function(event)
            if event == require('gtd').Event.Finish then
              vim.go.splitright = splitright
            end
          end,
        })
      end,
    },
  },
}
