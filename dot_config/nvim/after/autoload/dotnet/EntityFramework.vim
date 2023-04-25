function dotnet#EntityFramework#entityname(file_name) abort
  return substitute(dotnet#classname(a:file_name), 'EntityTypeConfiguration', '', '')
endfunction
