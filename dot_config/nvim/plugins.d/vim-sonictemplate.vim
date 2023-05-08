" hook_source {{{
const s:Vital = vital#vital#new()
const s:XML = s:Vital.import('Web.XML')

function s:find_csproj(cs) abort
  const l:cs = fnamemodify(expand(a:cs), ':p')

  let l:dir = fnamemodify(l:cs, ':h')
  while '/' !=# l:dir
    let l:files = readdir(l:dir)
    for l:file in l:files
      if 'csproj' ==# fnamemodify(l:file, ':e')
        return l:dir .. '/' .. l:file
      endif
    endfor
    let l:dir = fnamemodify(l:dir, ':h')
  endwhile
  throw 'csproj not found.'
endfunction

function s:root_namespace(csproj) abort
  const l:path = fnamemodify(expand(a:csproj), ':p')
  call s:assert_filereadable(l:path)

  const l:csproj = s:XML.parseFile(l:path)
  const l:root_namespace = l:csproj.find('PropertyGroup').find('RootNamespace')

  if !empty(l:root_namespace)
    return l:root_namespace.value()
  endif

  return fnamemodify(l:path, ':t:r')
endfunction

function s:find_root_namespace(path)
  return s:root_namespace(s:find_csproj(a:path))
endfunction

function s:parent_directory(path)
  return fnamemodify(a:path, ':h')
endfunction

function s:project_root(path)
  return s:parent_directory(s:find_csproj(a:path))
endfunction

function s:relative_path(from, to)
  return substitute(a:to, a:from, '', '')
endfunction

function s:path_to_namespace(path)
  return substitute(a:path, '/', '.', 'g')
endfunction

function s:assert_filereadable(path)
  if !filereadable(a:path)
    throw a:path .. ' is not readable.'
  endif
endfunction

function s:assert_csharp_source(file_name)
  if 'cs' !=# fnamemodify(a:file_name, ':e')
    throw fnamemodify(a:file_name, ':t') .. 'is not C# source file.'
  endif
endfunction

" Determine namespace of a:cs
function g:CSNamespace(cs) abort
  const l:cs = fnamemodify(expand(a:cs), ':p')
  call s:assert_csharp_source(l:cs)

  return s:find_root_namespace(l:cs) .. s:path_to_namespace(s:relative_path(s:project_root(l:cs), s:parent_directory(l:cs)))
endfunction

function g:CSClassName(file_name) abort
  const l:file_name = fnamemodify(expand(a:file_name), ':p:t:r')
  if l:file_name =~# '\.razor$'
    return fnamemodify(l:file_name, ':r')
  endif
  return l:file_name
endfunction

function g:CSEntityName(file_name) abort
    return substitute(g:CSClassName(a:file_name), 'EntityTypeConfiguration', '', '')
endfunction
" }}}
