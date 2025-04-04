" ==========================================================================
" Buffer List
" ==========================================================================

if exists('g:loaded_buffer_picker')
  finish
endif
let g:loaded_buffer_picker = 1

" --------------------------------------------------------------------------

function! s:Buffers()
  let l:current_buffer_number = bufnr('%')
  let l:raw_buffers = getbufinfo({'buflisted': 1})
  let l:buffers = []

  for buffer in l:raw_buffers
    let l:buffer_info = {
          \ 'number': buffer.bufnr,
          \ 'name': buffer.name,
          \ 'path': s:FormattedPath(buffer.name),
          \ 'is_current': buffer.bufnr == l:current_buffer_number,
          \ 'is_modified': getbufvar(buffer.bufnr, '&modified'),
          \ }
    call add(l:buffers, l:buffer_info)
  endfor

  return l:buffers
endfunction

function! s:FormattedPath(buffer_path)
  if empty(a:buffer_path)
    return '[No Name]'
  endif

  if a:buffer_path == getcwd()
    return fnamemodify(a:buffer_path, ':t') . '/'
  else
    return fnamemodify(a:buffer_path, ':.')
  endif
endfunction

" --------------------------------------------------------------------------

function! s:MenuWindow()
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


function! s:PopulateMenuWindow(buffers)
  let b:buffer_numbers = []

  for buffer in a:buffers
    call add(b:buffer_numbers, buffer.number)

    let l:modified_marker = buffer.is_modified ? '[+] ' : '    '
    let l:current_buffer_marker = buffer.is_current ? ' *' : '  '
    let l:line = printf("%3d %s%s%s", buffer.number, l:modified_marker, buffer.path, l:current_buffer_marker)

    call append(line('$') -1, l:line)
  endfor

  " Remove empty last line
  $delete _
endfunction

" --------------------------------------------------------------------------

function! s:SelectBuffer()
  " Get current line
  let l:line_number = line('.')

  if exists('b:buffer_numbers') && l:line_number <= len(b:buffer_numbers)
    " Get the buffer number
    let l:selected_buffer = get(b:buffer_numbers, l:line_number - 1, -1)

    " Close the menu window and open the buffer
    if l:selected_buffer > 0
      bwipeout

      execute 'buffer ' . l:selected_buffer
    endif
  endif
endfunction


function! s:CancelSelection()
  bwipeout
endfunction


function! s:PluginKeymaps()
  nnoremap <buffer> <silent> <cr> :call <sid>SelectBuffer()<cr>
  nnoremap <buffer> <silent> <esc> :call <sid>CancelSelection()<cr>
  nnoremap <buffer> <silent> q :call <sid>CancelSelection()<cr>
endfunction

" --------------------------------------------------------------------------

function! BufferList()
  let l:buffer_list = s:Buffers()
  
  call s:MenuWindow()
  call s:PopulateMenuWindow(l:buffer_list)

  " Jump to the top
  normal! gg

  call s:PluginKeymaps()
endfunction

nnoremap <leader>bb :call BufferList()<cr>

