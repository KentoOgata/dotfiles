function! s:ProcessShebang() abort
  const l:line = getline(1)
  " #!/bin/env -S deno run --ext js
  if l:line =~# '#!/\%(usr/\)\{,1}bin/env -S deno run'
    const l:denofts = #{
          \ ts: 'typescript',
          \ tsx: 'typescriptreact',
          \ js: 'javascript',
          \ jsx: 'javascriptreact',
          \ }

    const l:ext = l:line->matchstr(
         \ l:denofts->keys()->join('\|')->printf('--ext\s\+\zs\(%s\)\ze')
         \ )

    if ! l:ext->empty()
      execute 'setfiletype' l:denofts[l:ext]
    endif

    return
  endif
endfunction

augroup FileTypeDetect
  autocmd!
  autocmd BufNewFile,BufReadPost *.org setfiletype org
  " Stored Procedureファイルの拡張子を.SQLにする不届き者の対策
  autocmd BufNewFile,BufRead *.SQL setfiletype sql
  autocmd BufReadPost * call s:ProcessShebang()
  autocmd BufNewfile,BufReadPost Directory.Build.props setfiletype xml
augroup END
