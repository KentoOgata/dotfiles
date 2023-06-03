" hook_source {{{
let g:searchx = #{
      \ auto_accept: v:true,
      \ scrolloff: &scrolloff,
      \ scrolltime: 15,
      \ nohlsearch: #{
      \   jump: v:true,
      \ },
      \ markers: split('ASDFGHJKLQWERTYUIOPZXCVBNM', '.\zs'),
      \ }

const g:MigemoPrompt = '(Migemo):'
function! g:searchx.convert(input) abort
  if a:input[: g:MigemoPrompt->len() - 1] ==# g:MigemoPrompt
    const input = a:input[g:MigemoPrompt->len() :]
    return input->len() < 2
          \ ? input
          \ : kensaku#query(input)
  else
    return a:input->substitute('\s', '.\\{-}', 'g')
  endif
endfunction

function! g:ToggleMigemoSearch() abort
  const cmdtype = getcmdtype()
  if cmdtype ==# '@'
    const cmdline = getcmdline()
    if cmdline =~# $'^{g:MigemoPrompt}'
      call setcmdline(cmdline[g:MigemoPrompt->len() :])
    else
      call setcmdline(g:MigemoPrompt .. cmdline)
    endif
  endif
endfunction
autocmd VimRc User SearchxEnter cnoremap <buffer> <C-j> <Cmd>call g:ToggleMigemoSearch()<CR>
autocmd VimRc User SearchxLeave cunmap <buffer> <C-j>
" }}}
