" autoload/notes/wikilink.vim - Functions for working with Obsidian-style wikilinks

" PUBLIC API -----------------------------------------------------------------

" Returns true if cursor is positioned inside a wikilink [[...]]
function! notes#wikilink#is_cursor_inside_wikilink() abort
  let brackets = s:wikilink_brackets()

  " Cursor is inside wikilink if all conditions are met
  return s:is_proper_bracket_order(brackets.opening_position, brackets.closing_position) &&
      \ s:is_cursor_after_opening(brackets.cursor_position, brackets.opening_position) &&
      \ s:is_cursor_before_closing(brackets.cursor_position, brackets.closing_position)
endfunction

" Returns the text content of a wikilink where the cursor is positioned
" Returns empty string if cursor is not inside a wikilink
function! notes#wikilink#wikilink_text() abort
  if !notes#wikilink#is_cursor_inside_wikilink()
    return ''
  endif

  let brackets = s:wikilink_brackets()

  " Extract the text between the brackets (excluding the brackets themselves)
  let wikilink_text = brackets.current_line[brackets.opening_position + 2 : brackets.closing_position - 1]
  return wikilink_text
endfunction

" Returns the target filename from a wikilink text, handling the pipe alias syntax
" For [[filename]] returns filename
" For [[filename|alias]] returns filename
function! notes#wikilink#target_filename(wikilink_text) abort
  if empty(a:wikilink_text)
    return ''
  endif

  " Check if the wikilink contains a pipe character
  let pipe_index = stridx(a:wikilink_text, '|')

  if pipe_index != -1
    " Return the part before the pipe (the actual filename)
    return a:wikilink_text[0:pipe_index-1]
  endif

  " No pipe found, return the entire wikilink text
  return a:wikilink_text
endfunction

" Returns a file path with the appropriate extension for the given wikilink text
" Adds .md extension if not already present
" Handles [[filename|alias]] syntax by using the part before the pipe
function! notes#wikilink#file_path(wikilink_text) abort
  " Return empty string if input is empty
  if empty(a:wikilink_text)
    return ''
  endif

  " Get the target filename from the wikilink text
  let target_filename = notes#wikilink#target_filename(a:wikilink_text)

  " Use as-is if already has extension, otherwise add .md
  if s:has_file_extension(target_filename)
    return target_filename
  endif

  return target_filename . '.md'
endfunction

" Returns the file path for the wikilink under the cursor
" Returns empty string if cursor is not on a wikilink
function! notes#wikilink#current_file_path() abort
  " Check if cursor is on a wikilink
  if !notes#wikilink#is_cursor_inside_wikilink()
    return ''
  endif

  " Get the wikilink text
  let link_text = notes#wikilink#wikilink_text()

  " Convert to file path
  return notes#wikilink#file_path(link_text)
endfunction

" Follows the wikilink under the cursor
function! notes#wikilink#follow_wikilink() abort
  " Check if cursor is on a wikilink
  if !notes#wikilink#is_cursor_inside_wikilink()
    " Not on a wikilink, fall back to Vim's default gf behavior
    execute "normal! \<C-]>gf"
    return
  endif

  " Get the complete file path for the wikilink
  let file_path = notes#wikilink#current_file_path()

  " Open or create the file
  call s:open_or_create_file(file_path)
endfunction

" PRIVATE HELPERS ------------------------------------------------------------

" Returns a dictionary with wikilink bracket information for current cursor position
function! s:wikilink_brackets() abort
  let brackets = {}
  let brackets.current_line = getline('.')
  let brackets.cursor_position = col('.') - 1
  let brackets.opening_position = s:opening_bracket_position(brackets.current_line, brackets.cursor_position)
  let brackets.closing_position = s:closing_bracket_position(brackets.current_line, brackets.cursor_position)
  return brackets
endfunction

" Returns position of the opening wikilink bracket or -1 if not found
function! s:opening_bracket_position(line, cursor_position) abort
  return strridx(a:line, '[[', a:cursor_position)
endfunction

" Returns position of the closing wikilink bracket or -1 if not found
function! s:closing_bracket_position(line, cursor_position) abort
  return stridx(a:line, ']]', a:cursor_position)
endfunction

" Opens existing file or creates a new one with the given path
function! s:open_or_create_file(file_path) abort
  if empty(a:file_path)
    echo "No valid file path found"
    return
  endif

  " Try to find the file using Vim's file searching functionality
  let found_file = findfile(a:file_path, '**')

  if !empty(found_file)
    " File exists, open it
    execute "edit " . fnameescape(found_file)
  else
    " File doesn't exist, create a new buffer with this name
    execute "edit " . fnameescape(a:file_path)
    echo "Created new file: " . a:file_path
  endif
endfunction

" Boolean functions (predicate functions)
" --------------------------------------

" Returns true if the opening bracket comes before the closing bracket
function! s:is_proper_bracket_order(opening_position, closing_position) abort
  return a:opening_position != -1 && a:closing_position != -1 && a:opening_position < a:closing_position
endfunction

" Returns true if the cursor is positioned after the opening bracket
function! s:is_cursor_after_opening(cursor_position, opening_position) abort
  return a:cursor_position >= a:opening_position + 2
endfunction

" Returns true if the cursor is positioned before the closing bracket
function! s:is_cursor_before_closing(cursor_position, closing_position) abort
  return a:cursor_position <= a:closing_position - 1
endfunction

" Returns true if the given text already has a file extension
function! s:has_file_extension(text) abort
  return a:text =~ '\.\w\+$'
endfunction
