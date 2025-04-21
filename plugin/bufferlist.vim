" ==========================================================================
" Buffer List
" ==========================================================================

if exists('g:loaded_buffer_picker')
  finish
endif

let g:loaded_buffer_picker = 1

" -- Commands and Keymaps --------------------------------------------------
command! BufferList :call BufferList()
nnoremap <leader>bb :BufferList<cr>

" -- Script Variables ------------------------------------------------------
let s:current_window_id = 0

" -- Global Functions ------------------------------------------------------
function! BufferList() abort
  let s:current_window_id = win_getid()
  let l:buffer_list = s:buffers()
   
  call s:create_menu_window()
  call s:populate_menu_window(l:buffer_list)

  " Jump to the top
  normal! gg

  call s:plugin_keymaps()
endfunction

" -- Process Raw Buffer Info -----------------------------------------------
function! s:buffers() abort
  let l:current_buffer_number = bufnr('%')
  let l:raw_buffers = getbufinfo({'buflisted': 1})
  let l:buffers = []

  for buffer in l:raw_buffers
    let l:buffer_info = {
          \ 'number': buffer.bufnr,
          \ 'name': buffer.name,
          \ 'path': s:formatted_path(buffer.name),
          \ 'is_current': buffer.bufnr == l:current_buffer_number,
          \ 'is_modified': getbufvar(buffer.bufnr, '&modified'),
          \ }
    call add(l:buffers, l:buffer_info)
  endfor

  return l:buffers
endfunction

function! s:formatted_path(buffer_path) abort
  if empty(a:buffer_path)
    return '[No Name]'
  endif

  if a:buffer_path == getcwd()
    return fnamemodify(a:buffer_path, ':t') . '/'
  else
    return fnamemodify(a:buffer_path, ':.')
  endif
endfunction

" -- Buffer List Window ----------------------------------------------------

function! s:create_menu_window() abort
  botright 10new

  setlocal buftype=nofile
  setlocal bufhidden=wipe
  setlocal noswapfile
  setlocal nowrap
  setlocal nobuflisted
  setlocal nonumber
  setlocal norelativenumber
  setlocal cursorline

  " Window name
  silent file [Buffer List]
endfunction


function! s:populate_menu_window(buffers) abort
  let b:buffer_numbers = []

  for buffer in a:buffers
    call add(b:buffer_numbers, buffer.number)

    let l:modified_marker = buffer.is_modified ? '  🏄' : '    '
    let l:current_buffer_marker = buffer.is_current ? ' ☕' : '  '
    let l:line = printf("%3d %s%s%s", buffer.number, l:modified_marker, buffer.path, l:current_buffer_marker)

    call append(line('$') -1, l:line)
  endfor

  " Remove empty last line
  $delete _
endfunction

" -- Script Commands and Keymaps --------------------------------------------------

function! s:select_buffer() abort
  if s:is_invalid_selection()
    return
  endif
 
  let l:selected_buffer = s:get_selected_buffer()

  if s:is_invalid_buffer(l:selected_buffer)
    return
  endif

  let l:buffer_to_load = l:selected_buffer

  bwipeout

  call s:return_to_current_window()

  execute 'buffer ' . l:buffer_to_load
endfunction

function! s:cancel_selection() abort
  bwipeout
endfunction


function! s:plugin_keymaps() abort
  nnoremap <buffer> <silent> <cr> :call <sid>select_buffer()<cr>
  nnoremap <buffer> <silent> <esc> :call <sid>cancel_selection()<cr>
  nnoremap <buffer> <silent> q :call <sid>cancel_selection()<cr>
endfunction

" -- Boolean Functions -----------------------------------------------------

function! s:is_invalid_selection() abort
  return !exists('b:buffer_numbers') || line('.') > len(b:buffer_numbers)
endfunction

function! s:get_selected_buffer() abort
  let l:line_number = line('.')

  return get(b:buffer_numbers, l:line_number -1, -1)
endfunction

function! s:is_invalid_buffer(buffer_number) abort
  return a:buffer_number <= 0
endfunction

function! s:return_to_current_window() abort
  if win_id2win(s:current_window_id) > 0
    call win_gotoid(s:current_window_id)
  endif
endfunction

