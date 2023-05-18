" ORIGINAL SOURCE: https://github.com/yuki-yano/dotfiles/blob/main/.vimrc
function! s:DefKeymap(force_map, args) abort
  const modes = a:args[0]
  const mapargs = join(a:args[1:], ' ')
  const cmd = (a:force_map || mapargs =~? '<Plug>') ? 'map' : 'noremap'
  for mode in split(modes, '.\zs')
    if index(split('nvsxoilct', '.\zs'), mode) < 0
      echoerr 'Invalid mode is detected: ' .. mode
      continue
    endif
    execute mode .. cmd mapargs
  endfor
endfunction
command! -nargs=+ -bang Keymap call <SID>DefKeymap('<bang>' ==# '!', [<f-args>])

function s:findRoot(path, rootPattern) abort
  let path = a:path->isdirectory() ? a:path : a:path->fnamemodify(':h')
  while path !=# '/' && path->readdir({ fname -> fname ==# a:rootPattern })->empty()
    let path = path->fnamemodify(':h')
  endwhile
  return path
endfunction

function! s:OpenTerminal(command, shell, bang) abort
  execute a:command $'term://{
        \   &l:buftype->empty() && !bufname()->empty()
        \     ? a:bang ? s:findRoot(expand('%'), '.git') : "%:h"
        \     : getcwd()
        \ }//{a:shell}'
endfunction
command -bang Shell call s:OpenTerminal('edit', $SHELL, '<bang>' ==# '!')
command -bang HShell call s:OpenTerminal('belowright split', $SHELL, '<bang>' ==# '!')
command -bang VShell call s:OpenTerminal('belowright vsplit', $SHELL, '<bang>' ==# '!')
