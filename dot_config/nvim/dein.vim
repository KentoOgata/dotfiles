const s:deincache = stdpath('cache') .. '/dein'

let $DEIN_CONFIG_DIR= stdpath('config') .. '/plugins.d'

function! s:deinsetup() abort
  call dein#options(#{
        \ install_progress_type: 'floating',
        \ auto_remote_plugins: v:true,
        \ lazy_rplugins: v:true,
        \ install_check_diff: v:true,
        \ enable_notification: v:true,
        \ })
  if dein#min#load_state(s:deincache)
    call dein#begin(s:deincache)
    for toml in
          \ $DEIN_CONFIG_DIR
          \ ->readdir({ fname -> fname->fnamemodify(':e') ==# 'toml' })
          \ ->map({ _, fname -> [$DEIN_CONFIG_DIR, fname]->join('/') })
      call dein#load_toml(toml)
    endfor
    call dein#end()
    if dein#check_install()
      call dein#install()
    endif
    call dein#save_state()
  endif
endfunction

const s:deinrtp = s:deincache .. '/repos/github.com/Shougo/dein.vim'
execute 'set runtimepath^=' .. s:deinrtp
try
  call s:deinsetup()
catch /^\%(Vim\%((\a\+)\)\=:\)\{,1}E117:/
  echom system([
        \ 'git',
        \ 'clone',
        \ 'https://github.com/Shougo/dein.vim.git',
        \ s:deinrtp,
        \ ])
  call s:deinsetup()
endtry

" vim:ft=vim expandtab tabstop=2 shiftwidth=2
