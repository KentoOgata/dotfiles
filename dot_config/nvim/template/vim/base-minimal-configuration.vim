const s:packpath = expand('<script>:p:h')
let &packpath = s:packpath
const s:ToPackPath = { name -> s:packpath .. '/pack/github.com/opt/' .. name }

function s:PackAdd(ghrepo) abort
  const plugin = #{
        \ path: s:ToPackPath(a:ghrepo),
        \ repo: $'https://github.com/{a:ghrepo}.git',
        \ name: a:ghrepo,
        \ }
  if !isdirectory(plugin.path)
    call system(['git', 'clone', plugin.repo, plugin.path])
  endif
  exec 'packadd' plugin.name
endfunction

call s:PackAdd({{_cursor_}})
