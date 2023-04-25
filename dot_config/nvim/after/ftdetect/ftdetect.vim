function! g:ProcessShebang() abort
  const l:line = getline(1)
  " #!/bin/env -S deno run --ext js
  if l:line =~# '#!/\%(usr/\)\{,1}bin/env -S deno run'
    const l:denofts = #{
          \ ts: 'typescript',
          \ tsx: 'typescriptreact',
          \ js: 'javascript',
          \ jsx: 'javascriptreact',
          \ }

    const l:ext = matchstr(
          \ l:line,
          \ '--ext\s\+\zs\(' .. l:denofts->keys()->join('\|') .. '\)\ze'
          \)
    if l:ext->empty()
      return
    endif

    " l:denoftsにない値はl:extに入ってない
    execute 'setfiletype' l:denofts[l:ext]
    return
  endif
endfunction

augroup FileTypeDetect
  autocmd!
  autocmd BufNewFile,BufReadPost *.org setfiletype org
  " Stored Procedureファイルの拡張子を.SQLにする不届き者の対策
  autocmd BufNewFile,BufRead *.SQL setfiletype sql
  autocmd BufReadPost * call g:ProcessShebang()
augroup END
