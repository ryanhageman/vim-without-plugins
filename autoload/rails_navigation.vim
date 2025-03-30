" ==========================================================================
" autoload/rails_navigation.vim
" Navigation functions for Rails projects
" ==========================================================================

if exists('g:autoloaded_rails_navigation')
  finish
endif
let g:autoloaded_rails_navigation = 1


function! rails_navigation#setup()
  setlocal includeexpr=rails_navigation#rails_file_path(v:fname)

  " Common Rails file extensions
  setlocal suffixesadd=.rb,.erb,.yml,.json,.js,.css,.scss

  " Common Rails paths
  setlocal path+=app,app/models,app/controllers,app/views,app/helpers,config,lib,test,spec
endfunction


" -- Filename Transformations ----------------------------------------------

" Convert a Ruby name (class, module, etc.) to its corresponding filename
function! rails_navigation#filename_from(ruby_name)
  let filename = a:ruby_name
  let filename = substitute(filename, '::', '/', 'g')
  let filename = substitute(filename, '\v([A-Z]+)([A-Z][a-z])', '\1_\2', 'g')
  let filename = substitute(filename, '\v([a-z\d])([A-Z])', '\1_\2', 'g')
  let filename = tolower(filename)
  return filename
endfunction


" -- Conditions? -----------------------------------------------------------

function! s:name_includes_a_directory(name)
  return name =~ '/'
endfunction


" -- File Path Transformations ---------------------------------------------

function! s:model_file_path_from(text)
  let model_name = substitute(a:text, '\v(belongs_to|has_many|has_one|has_and_belongs_to_many)\s+:(\w+)', '\2', '')

  return 'app/models/' . rails_navigation#filename_from(model_name) . '.rb'
endfunction

function! s:partial_file_path_from(text)
  let current_file_path = expand('%:p')
  let view_directory = matchstr(current_file_path, '\v.*/app/views/\zs.*\ze/[^/]+$')

  let partial_name = substitute(a:text, '\v(render\s+[''"])([^''"]*)([''"](,|\))?)', '\2', '')
  
  if s:name_includes_a_directory(partial_name)
    let last_slash = strridx(partial_name, '/')
    let partial_name = partial_name[0:last_slash] . '_' . partial_name[last_slash+1:]
    return 'app/views/' . partial_name . '.html.erb'
  else
    return 'app/views/' . view_directory . '/_' . partial_name . '.html.erb'
  endif
endfunction

function! s:class_file_path_from(text)
  return rails_navigation#filename_from(a:text)
endfunction


" -- The Rails File With Path -------------------------------------------------

function! rails_navigation#rails_file_path(raw_filename)
  let new_filename = a:raw_filename

  let model_pattern = '\v(belongs_to|has_many|has_one|has_and_belongs_to_many)\s+:(\w+)'
  if new_filename =~ model_pattern
    return s:model_file_path_from(new_filename)
  endif

  let partial_pattern = '\v(render\s+[''"])([^''"]*)([''"](,|\))?)'
  if new_filename =~ partial_pattern
    return s:partial_file_path_from(new_filename)
  endif

  let class_pattern = '\v^[A-Z]\w+'
  if new_filename =~ class_pattern
    return s:class_file_path_from(new_filename)
  endif

  return new_filename
endfunction
