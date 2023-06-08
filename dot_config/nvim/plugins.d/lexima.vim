" hook_source {{{
function s:add_rules(shared, rules) abort
  call map(a:rules, { _, rule -> lexima#add_rule(a:shared->deepcopy()->extend(rule, 'error')) })
endfunction

call s:add_rules(
      \ #{ char: '<Tab>' },
      \ [
      \   #{ at: '\%#\s*\n\{,1}\s*)',   leave: ')' },
      \   #{ at: '\%#\s*\n\{,1}\s*]',   leave: ']' },
      \   #{ at: '\%#\s*\n\{,1}\s*}',   leave: '}' },
      \   #{ at: '\%#\s*\n\{,1}\s*"',   leave: '"' },
      \   #{ at: '\%#\s*\n\{,1}\s*''',  leave: "'" },
      \   #{ at: '\%#\s*\n\{,1}\s*`',   leave: '`' },
      \ ]
      \ )

call s:add_rules(
      \ #{ filetype: 'lua' },
      \ [
      \   #{ char: '<Tab>', at: '\%#\s*\n{,1}\s*end', leave: 'end' },
      \   #{ char: '<Tab>', at: 'function\(\s[a-zA-Z0-9\.\_:]\+\)\{,1}(.*\%#)', leave: ')', input_after: 'end' },
      \   #{ char: '<CR>', at: '\%#end', input_after: '<CR>' },
      \   #{ char: '<CR>', at: 'if\s.*\sthen\%#', input_after: '<CR>end' },
      \   #{ char: '<Space>', at: '\%#end', input_after: '<Space>' },
      \ ]
      \ )

call s:add_rules(
      \ #{ filetype: 'html' },
      \ [
      \   #{ char: '<Tab>', at: '\%#</\w\+>', leave: '>' },
      \   #{ char: '<CR>', at: '\%#<\w\+>', input_after: '<CR>' },
      \   #{ char: '>', at: '<\(\w\+\)\%(\s\+\w\+=\".\+\"\)*\%#', input_after: '</\1>', with_submatch: 1 },
      \   #{ char: '/', at: '<\(\w\+\)\(\s\+\w\+=\".\+\"\)*\%#', input: '>' },
      \   #{ char: '=', at: '\w\+\%#', input: '="', input_after: '"' },
      \ ]
      \ )

call s:add_rules(
      \ #{ filetype: ['cs', 'razor'] },
      \ [
      \   #{ char: '<Tab>', at: 'get\%( => [^;]\+\)*\%#;', leave: ';' },
      \   #{ char: '<Tab>', at: '\%(set\|init\)\%( => .\+\)*\%#; }', leave: '}' },
      \   #{ char: '<Tab>', at: '<\%([a-zA-Z0-9_\.]\+?\{,1}\)\%(,\s*[a-zA-Z0-9_\.]\+?\{,1}\)*>*\%#>', leave: '>' },
      \   #{ char: '<Space>', at: '\%(get\|set\|init\)\%#;', input: ' => ' },
      \   #{ char: '<Space>', at: '\%(@if\|\s\+if\|^if\)\%#', input: '<Space>(', input_after: ')' },
      \   #{ char: 'd', at: '#if \%#', input: 'DEBUG' },
      \   #{ char: '<CR>', at: '^\s*#if\s\+.\+\%#', input_after: '<CR>#endif' },
      \   #{ char: '<Space>', at: '@\{,1}\%(for\|while\|foreach\|switch\)\%#', input: '<Space>(', input_after: ')' },
      \   #{ char: '<BS>', at: '<\%#>', delete: '>' },
      \   #{ char: 'g', at: '{ \%# }', input: 'get', input_after: ';' },
      \   #{ char: 's', at: '{ get\%( => [^;]\+\)*; \%# }', input: 'set', input_after: ';' },
      \   #{ char: 'i', at: '{ get\%( => [^;]\+\)*; \%# }', input: 'init', input_after: ';' },
      \   #{ char: '<Space>', at: 'DbSet<\([0-9a-zA-Z<>_]\+\)> \w\+\%#', input: ' => Set<\1>();', with_submatch: 1 },
      \   #{ char: '<', at: '[a-zA-Z0-9_]\%#', input_after: '>' },
      \   #{ char: ';', at: '\%#.\+$', input: '<End>;', except: '\('..
      \     'for\s*([^)]*\%#)'..'\|'..
      \     '\%(get\|set\|init\)\%( => [^;]\+\)*\%#'..'\)'
      \   },
      \   #{ char: '<Space>', at: '\.\w\+(\%([^)]\+,\s\)*\<\%(new\|out\)\@!\w\+\%#)', input: '<Space>=><Space>' },
      \   #{ char: '$', except: '\%#"', input: '$"', input_after: '"' },
      \   #{ char: '<Space>', at: '\<pp\%#', input: '<BS><BS>Console.WriteLine(', input_after: ')' },
      \ ]
      \ )

call s:add_rules(
      \ #{ filetype: 'razor' },
      \ [
      \   #{ char: '*', at: '@\%#', input_after: '*@' },
      \   #{ char: '<Space>', at: '@\*\%#\*@', input_after: '<Space>' },
      \   #{ char: '<BS>', at: '@\*\s\%#\s\*@', input: '<BS><DEL>' },
      \   #{ char: '<BS>', at: '@\*\%#\*@', input: '<BS><BS>', delete: '*@' },
      \   #{ char: '/', at: '<[^>]\+\%#', input: '/>' },
      \   #{ char: '>', at: '<\(\w\+\)[^>]*\%#', with_submatch: 1, input: '>', input_after: '</\1>' },
      \   #{ char: '<CR>', at: '\%#</', input: '<CR>', input_after: '<CR>' },
      \   #{ char: '<Tab>', at: '\%#\n\{,1}\s*</\w\+>', leave: '>' }
      \ ]
      \ )

call s:add_rules(
      \ #{ filetype: 'vim' },
      \ [
      \   #{ char: '(', at: '\\\%#', input_after: '\)' },
      \   #{ char: '(', at: '\\%\%#', input_after: '\)' },
      \   #{ char: '<Tab>', at: '\%#\\)', leave: '\\)' },
      \   #{ char: '<BS>', at: '\\(\%#\\)', input: '<BS><BS>', delete: '\\)' },
      \   #{ char: '<BS>', at: '\\%(\%#\\)', input: '<BS><BS><BS>', delete: '\\)' },
      \ ]
      \ )

call s:add_rules(
      \ #{ filetype: ['lisp', 'scheme'] },
      \ [
      \   #{ char: "'", input: "'" },
      \   #{ char: '`', input: '`' },
      \ ]
      \ )

call s:add_rules(
      \ #{ char: '<Plug>(post-complete-function-symbol)' },
      \ [
      \   #{ except: '\%#(', input: '(', input_after: ')' },
      \   #{ input: '', priority: -1 },
      \ ]
      \ )

" input: >>, effect: `if (\%#)condition` -> `if (condition)`
call lexima#add_rule(#{ char: '>', at: '(>\%#)', input: '<BS><DEL><End>)' })

" cmdline rules
" `:g<space>` -> `:vimgrep \%# %`
AlterCmd g vimgrep <Space>%

" ORIGINAL:
"   SOURCE: https://github.com/yuki-yano/lexima-alter-command.vim/blob/main/autoload/lexima_alter_command.vim
"   LICENSE: https://github.com/yuki-yano/lexima-alter-command.vim/blob/main/LICENSE
function! g:AlterCommand(char, input, input_after = v:null) abort
  let space_rule = #{ mode: ':', at: '^\%(''<,''>\)\?' .. a:char, char: '<space>' }
  let cr_rule = #{ mode: ':', at: '^\%(''<,''>\)\?' .. a:char, char: '<cr>' }
  if !a:input->empty()
    let space_rule.input = '<C-w>' .. a:input .. '<space>'
    let cr_rule.input = '<C-w>' .. a:input .. '<cr>'
  endif
  if a:input_after isnot# v:null
    let space_rule.input_after = a:input_after
    let cr_rule.input_after = a:input_after
  endif
  call lexima#add_rule(space_rule)
  call lexima#add_rule(cr_rule)
endfunction

for altercmd in g:_alterCommands
  execute 'AlterCmd' altercmd.char altercmd.input altercmd.input_after ?? ''
endfor
unlet g:_alterCommands

" }}}
