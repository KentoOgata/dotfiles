" hook_source {{{
const s:Vital = vital#vital#new()
const s:XML = s:Vital.import('Web.XML')

function s:find_csproj(path) abort
  let dir = a:path->isdirectory() ? a:path : a:path->fnamemodify(':h')
  let files = dir->readdir({ fname -> fname->fnamemodify(':e') ==# 'csproj' })
  while '/' !=# dir && files->empty()
    let dir = dir->fnamemodify(':h')
    let files = dir->readdir({ fname -> fname->fnamemodify(':e') ==# 'csproj' })
  endwhile
  if dir ==# '/'
    throw 'csproj is not found.'
  endif
  return [dir, files[0]]->join('/')
endfunction

function s:root_namespace(path) abort
  const path = a:path->fnamemodify(':e') ==# 'csproj'
        \ ? a:path
        \ : s:find_csproj(a:path)
  const csproj = s:XML.parseFile(path)
  " root namespace
  const rns = csproj.find('PropertyGroup').find('RootNamespace')
  " RootNamespaceプロパティがなかった場合はcsprojファイルのファイル名を使う
  return !rns->empty()
        \ ? rns.value()
        \ : path->fnamemodify(':t:r')
endfunction

const s:find_root_namespace = { path -> s:root_namespace(path) }
const s:parent_directory = { path -> path->fnamemodify(':h') }
const s:project_root = { path -> s:parent_directory(s:find_csproj(path)) }
const s:relative_path = { from, to -> substitute(to, from, '', '') }
const s:path_to_namespace = { path -> substitute(path, '/', '.', 'g') }

" Determine namespace of a:cs
function g:CSNamespace(cs) abort
  const cs = expand(a:cs)->fnamemodify(':p')
  return s:find_root_namespace(cs) ..
        \ s:path_to_namespace(s:relative_path(s:project_root(cs), s:parent_directory(cs)))
endfunction

function g:CSClassName(fname) abort
  const fname = expand(a:fname)->fnamemodify(':p:t:r')
  return fname->fnamemodify(':e') ==# 'razor'
        \ ? fname->fnamemodify(':r')
        \ : fname
endfunction

function g:CSEntityName(fname) abort
    return g:CSClassName(a:fname)->substitute('EntityTypeConfiguration', '', '')
endfunction
" }}}
