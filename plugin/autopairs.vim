" ==========================================================================
" Autopairs
" ==========================================================================

if exists('g:loaded_autopairs')
  finish
endif

let g:loaded_autopairs = 1
" --------------------------------------------------------------------------

let s:pairs = {
  \ '(': ')',
  \ '[': ']',
  \ '{': '}',
  \ '"': '"',
  \ "'": "'",
  \ }

function! s:auto_pair(open) abort
  let l:close = get(s:pairs, a:open, '')

  if l:close ==# ''
    return a:open
  endif

  return a:open . l:close . "\<left>"
endfunction

function! s:is_inside_a_pair() abort
  let [l:line, l:col] = s:cursor_position()

  if s:is_cursor_at_line_edge()
    return 0
  endif

  for [l:open, l:close] in items(s:pairs)
    if l:line[l:col-1] ==# l:open && l:line[l:col] ==# l:close
      return 1
    endif
  endfor

  return 0
endfunction

" -- Handlers --------------------------------------------------------------
function! s:backspace_handler() abort
  if s:is_inside_a_pair()
    return "\<BS>\<Delete>"
  endif

  return "\<BS>"
endfunction

function! s:closing_character_handler(char) abort
  let [l:line, l:col] = s:cursor_position()

  if s:is_char_already_present(a:char)
    return "\<Right>"
  endif

  if has_key(s:pairs, a:char)
    return s:auto_pair(a:char)
  endif

  return a:char
endfunction

function! s:cursor_position() abort
  let l:line = getline('.')
  let l:col = col('.') - 1

  return [l:line, l:col]
endfunction


" -- Boolean Checks --------------------------------------------------------

function! s:is_cursor_at_line_edge() abort
  return s:is_beginning_of_line() || s:is_end_of_line()
endfunction

function! s:is_beginning_of_line() abort
  let l:col = col('.') - 1

  return l:col <= 0
endfunction

function! s:is_end_of_line() abort
  let [l:line, l:col] = s:cursor_position()

  return l:col >= len(l:line)
endfunction

function! s:is_char_already_present(char) abort
  let [l:line, l:col] = s:cursor_position()

  return l:col < len(l:line) && l:line[l:col] ==# a:char
endfunction


" -- Turn it on ------------------------------------------------------------

function! s:collect_all_chars() abort
  let l:all_chars = {}
  
  for [l:open, l:close] in items(s:pairs)
    let l:all_chars[l:open] = 1

    if l:open !=# l:close
      let l:all_chars[l:close] = 1
    endif
  endfor

  return keys(l:all_chars)
endfunction

function! s:setup_mappings() abort
  let l:all_chars = s:collect_all_chars()

  for l:char in l:all_chars
    let l:escaped_char = escape(l:char, '"|')

    if l:char ==# '"'
      inoremap <expr> " <sid>closing_character_handler('"')
    else
      execute 'inoremap <expr> ' . l:escaped_char . ' <sid>closing_character_handler("' . l:escaped_char . '")'
    endif
  endfor

  inoremap <expr> <BS> <sid>backspace_handler()
endfunction

call s:setup_mappings()

