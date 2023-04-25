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
