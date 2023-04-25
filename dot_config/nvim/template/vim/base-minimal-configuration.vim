const s:packpath = expand('<sfile>:h')
const s:optpackpath = s:packpath .. '/pack/github.com/opt/'
if !isdirectory(s:optpackpath)
  call mkdir(s:optpackpath, 'p')
endif
exec printf('set packpath=%s', s:packpath)

function s:packadd(ghrepo)
  const l:installdir = s:optpackpath .. a:ghrepo
  if !isdirectory(l:installdir)
    call system(printf('git clone https://github.com/%s.git %s', a:ghrepo, l:installdir))
  endif
  exec printf('packadd %s', a:ghrepo)
endfunction

call s:packadd({{_cursor_}})
