if exists('g:loaded_buffer_picker')
  finish
endif
let g:loaded_buffer_picker = 1

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

  " Window Name
  silent file [Buffer List]
endfunction


function! s:CurrentBuffers()
  return getbufinfo({'buflisted': 1})
endfunction


function! s:ShortenedPath(buffer_path)
  if empty(a:buffer_path)
    return '[No Name]'
  endif
  
  " Check if the path is the same as the current directory
  if a:buffer_path == getcwd()
    return fnamemodify(a:buffer_path, ':t') . '/'
  else
    return fnamemodify(a:buffer_path, ':.')
  endif
endfunction


function! s:BufferListEntry(buffer, current_buffer)
  let l:modified = getbufvar(a:buffer.bufnr, '&modified') ? '[+] ' : '    '
  let l:active = a:buffer.bufnr == a:current_buffer ? ' *' : '  '
  let l:path = s:ShortenedPath(a:buffer.name)
  return printf("%3d %s%s%s", a:buffer.bufnr, l:modified, l:path, l:active)
endfunction


function! s:MenuContents(buffers, current_buffer)
  let b:buffer_numbers = []

  for buffer in a:buffers
    " Store buffer number for the line
    call add(b:buffer_numbers, buffer.bufnr)

    let l:line = s:BufferListEntry(buffer, a:current_buffer)
    " Show buffer line
    call append(line('$') - 1, l:line)
  endfor

  " Remove empty last line
  $delete _
endfunction

" --------------------------------------------------------------------------

function! s:SelectBuffer()
  " Get current line
  let l:line_number = line('.')

  " Only if there's valid data
  if exists('b:buffer_numbers') && l:line_number <= len(b:buffer_numbers)
    " Grab the buffer number
    let l:selected_buffer = get(b:buffer_numbers, l:line_number - 1, -1)

    " Close the window
    if l:selected_buffer > 0
      bwipeout

      " Switch to the new buffer
      execute 'buffer ' . l:selected_buffer
    endif
  endif
endfunction


function! s:CancelSelection()
  bwipeout
endfunction

" --------------------------------------------------------------------------

function! BufferList()
  let l:current_buffer = bufnr('%')
  let l:buffers = s:CurrentBuffers()

  call s:MenuWindow()
  call s:MenuContents(l:buffers, l:current_buffer)

  " Jump to the top
  normal! gg

  nnoremap <buffer> <silent> <cr> :call <sid>SelectBuffer()<cr>
  nnoremap <buffer> <silent> <esc> :call <sid>CancelSelection()<cr>
  nnoremap <buffer> <silent> q :call <sid>CancelSelection()<cr>
endfunction

nnoremap <leader>bb :call BufferList()<cr>

