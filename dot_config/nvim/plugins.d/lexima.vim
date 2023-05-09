" hook_source {{{
let l:general_leaveparen_rules = [
      \ #{ char: '<Tab>', at: '\%#\s*\n\{,1}\s*)', leave: ')' },
      \ #{ char: '<Tab>', at: '\%#\s*\n\{,1}\s*]', leave: ']' },
      \ #{ char: '<Tab>', at: '\%#\s*\n\{,1}\s*}', leave: '}' },
      \ #{ char: '<Tab>', at: '\%#\s*\n\{,1}\s*"', leave: '"' },
      \ #{ char: '<Tab>', at: '\%#\s*\n\{,1}\s*''', leave: "'" },
      \ #{ char: '<Tab>', at: '\%#\s*\n\{,1}\s*`', leave: '`' },
      \]

let l:lua_rules = [
      \ #{ filetype: 'lua', char: '<Tab>', at: '\%#\s*\n{,1}\s*end', leave: 'end' },
      \ #{ filetype: 'lua', char: '<Tab>', at: 'function\(\s[a-zA-Z0-9\.\_:]\+\)\{,1}(.*\%#)', leave: ')', input_after: 'end' },
      \ #{ filetype: 'lua', char: '<CR>', at: '\%#end', input_after: '<CR>' },
      \ #{ filetype: 'lua', char: '<CR>', at: 'if\s.*\sthen\%#', input_after: '<CR>end' },
      \ #{ filetype: 'lua', char: '<Space>', at: '\%#end', input_after: '<Space>' },
      \]

let l:html_rules = [
      \ #{ filetype: 'html', char: '<Tab>', at: '\%#</\w\+>', leave: '>' },
      \ #{ filetype: 'html', char: '<CR>', at: '\%#<\w\+>', input_after: '<CR>' },
      \ #{ filetype: 'html', char: '>', at: '<\(\w\+\)\%(\s\+\w\+=\".\+\"\)*\%#', input_after: '</\1>', with_submatch: 1 },
      \ #{ filetype: 'html', char: '/', at: '<\(\w\+\)\(\s\+\w\+=\".\+\"\)*\%#', input: '>' },
      \ #{ filetype: 'html', char: '=', at: '\w\+\%#', input: '="', input_after: '"' },
      \]

let l:cs_rules = [
      \ #{ filetype: ['cs', 'razor'], char: '<Tab>', at: 'get\%( => [^;]\+\)*\%#;', leave: ';' },
      \ #{ filetype: ['cs', 'razor'], char: '<Tab>', at: '\%(set\|init\)\%( => .\+\)*\%#; }', leave: '}' },
      \ #{ filetype: ['cs', 'razor'], char: '<Tab>', at: '<\%([a-zA-Z0-9_\.]\+?\{,1}\)\%(,\s*[a-zA-Z0-9_\.]\+?\{,1}\)*>*\%#>', leave: '>' },
      \ #{ filetype: ['cs', 'razor'], char: '<Space>', at: '\%(get\|set\|init\)\%#;', input: ' => ' },
      \ #{ filetype: ['cs', 'razor'], char: '<Space>', at: '\%(@if\|\s\+if\|^if\)\%#', input: '<Space>(', input_after: ')' },
      \ #{ filetype: ['cs', 'razor'], char: 'd', at: '#if \%#', input: 'DEBUG' },
      \ #{ filetype: ['cs', 'razor'], char: '<CR>', at: '^\s*#if\s\+.\+\%#', input_after: '<CR>#endif' },
      \ #{ filetype: ['cs', 'razor'], char: '<Space>', at: '@\{,1}\%(for\|while\|foreach\|switch\)\%#', input: '<Space>(', input_after: ')' },
      \ #{ filetype: ['cs', 'razor'], char: '<BS>', at: '<\%#>', delete: '>' },
      \ #{ filetype: ['cs', 'razor'], char: 'g', at: '{ \%# }', input: 'get', input_after: ';' },
      \ #{ filetype: ['cs', 'razor'], char: 's', at: '{ get\%( => [^;]\+\)*; \%# }', input: 'set', input_after: ';' },
      \ #{ filetype: ['cs', 'razor'], char: 'i', at: '{ get\%( => [^;]\+\)*; \%# }', input: 'init', input_after: ';' },
      \ #{ filetype: ['cs', 'razor'], char: '<Space>', at: 'DbSet<\([0-9a-zA-Z<>_]\+\)> \w\+\%#', input: ' => Set<\1>();', with_submatch: 1 },
      \ #{ filetype: ['cs', 'razor'], char: '<', at: '[a-zA-Z0-9_]\%#', input_after: '>' },
      \ #{ filetype: ['cs', 'razor'], char: ';', at: 'for\s*([^)]*\%#)', input: ';' },
      \ #{ filetype: ['cs', 'razor'], char: ';', at: '\%(get\|set\|init\)\%( => [^;]\+\)*\%#', input: ';' },
      \ #{ filetype: ['cs', 'razor'], char: ';', at: '\%#.\+$', input: '<End>;' },
      \ #{ filetype: ['cs', 'razor'], char: '<Space>', at: '\.\w\+(\%([^)]\+,\s\)*\w\+\%#)', input: '<Space>=><Space>' },
      \]
call lexima#add_rule(#{ filetype: ['cs', 'razor'], char: '$', input: '$"', input_after: '"' })
call lexima#add_rule(#{ filetype: ['cs', 'razor'], char: '<Space>', at: '\<pp\%#', input: '<BS><BS>Console.WriteLine(', input_after: ')' })

let l:razor_rules = [
      \ #{ filetype: 'razor', char: '*', at: '@\%#', input_after: '*@' },
      \ #{ filetype: 'razor', char: '<Space>', at: '@\*\%#\*@', input_after: '<Space>' },
      \ #{ filetype: 'razor', char: '<BS>', at: '@\*\s\%#\s\*@', input: '<BS><DEL>' },
      \ #{ filetype: 'razor', char: '<BS>', at: '@\*\%#\*@', input: '<BS><BS>', delete: '*@' },
      \ #{ filetype: 'razor', char: '/', at: '<[^>]\+\%#', input: '/>' },
      \ #{ filetype: 'razor', char: '>', at: '<\(\w\+\)[^>]*\%#', with_submatch: 1, input: '>', input_after: '</\1>' },
      \ #{ filetype: 'razor', char: '<CR>', at: '\%#</', input: '<CR>', input_after: '<CR>' },
      \ #{ filetype: 'razor', char: '<Tab>', at: '\%#\n\{,1}\s*</\w\+>', leave: '>' }
      \]

let l:lisp_rules = [
      \ #{ filetype: ['scheme', 'lisp'], char: "'", input: "'" },
      \]

call lexima#add_rule(#{ filetype: ['vim', 'lua'], char: '(', at: '\\\%#', input_after: '\)' })
call lexima#add_rule(#{ filetype: ['vim', 'lua'], char: '(', at: '\\%\%#', input_after: '\)' })
call lexima#add_rule(#{ filetype: ['vim', 'lua'], char: '<Tab>', at: '\%#\\)', leave: '\\)' })
call lexima#add_rule(#{ filetype: ['vim', 'lua'], char: '<BS>', at: '\\(\%#\\)', input: '<BS><BS>', delete: '\\)' })
call lexima#add_rule(#{ filetype: ['vim', 'lua'], char: '<BS>', at: '\\%(\%#\\)', input: '<BS><BS><BS>', delete: '\\)' })

call map(
      \ [
      \   l:general_leaveparen_rules,
      \   l:lua_rules,
      \   l:html_rules,
      \   l:cs_rules,
      \   l:razor_rules,
      \   l:lisp_rules,
      \ ],
      \ { _, rules -> map(rules, { _, rule -> lexima#add_rule(rule) }) }
      \)

" input: >>, effect: `if (\%#)condition` -> `if (condition)`
call lexima#add_rule(#{ char: '>', at: '(>\%#)', input: '<BS><DEL><End>)' })

" cmdline rules
" `:g<space>` -> `:vimgrep \%# %`
call lexima#add_rule(#{ mode: ':', at: '^\%(''<,''>\)\?g', char: '<space>', input: '<C-w>vimgrep ', input_after: ' %'  })

" }}}
