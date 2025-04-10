" ==========================================================================
" Keymaps
" ==========================================================================

" Vim Settings (vimrc)
nnoremap <leader>ve :e $MYVIMRC<cr>

" Buffer
nnoremap <leader>bp :bp<cr>|                " previous buffer
nnoremap <leader>bn :bn<cr>|                " next buffer
nnoremap <leader>bd :bd<cr>|                " delete the buffer
nnoremap <leader><tab> <c-^>|               " swap with alternate buffer
" BufferList for bb

" Files
nnoremap <leader>fs :write<cr>|             " file save (:write)
nnoremap <leader>ff :e|                     " find file 

" Windows
nnoremap <leader>ww <c-w>w|                 " swap Windows
nnoremap <leader>wv <c-w>v|                 " vertical split
nnoremap <leader>ws <c-w>s|                 " horizontal split
nnoremap <leader>wt :term<cr>|              " open a terminal split
nnoremap <c-j> <c-w><c-j>|                  " move to the window below
nnoremap <c-k> <c-w><c-k>|                  " move to the window above
nnoremap <c-h> <c-w><c-h>|                  " move to the window left
nnoremap <c-l> <c-w><c-l>|                  " move to the window right

" Terminal
nnoremap <leader>' :term<cr>|               " open a terminal split
nnoremap <c-,> :call ToggleTerminal()<CR>
tnoremap <c-,> <c-\><c-n>:call ToggleTerminal()<CR>
tnoremap <c-j> <c-w>j|                      " move to the window below
tnoremap <c-k> <c-w>k|                      " move to the window above
tnoremap <c-h> <c-w>h|                      " move to the window left
tnoremap <c-l> <c-w>l|                      " move to the window right

" Color Schemes
nnoremap <leader>cc :echo synIDattr(synID(line('.'), col('.'), 1), 'name')<cr>| " token under the cursor for colorscheme

function! ToggleTerminal() abort
    let terminal_buffer = s:find_terminal_buffer()
    
    if terminal_buffer > 0
        let terminal_window = s:is_buffer_visible(terminal_buffer)
        
        if terminal_window > 0
            call s:hide_terminal_window(terminal_window)
        else
            call s:show_existing_terminal(terminal_buffer)
        endif
    else
        call s:create_new_terminal()
    endif
endfunction

function! s:find_terminal_buffer() abort
  for buffer in getbufinfo()
    if getbufvar(buffer.bufnr, '&buftype') == 'terminal'
      return buffer.bufnr
    endif
  endfor

  return 0
endfunction

function! s:is_buffer_visible(buffer_number) abort
    for window in getwininfo()
        if window.bufnr == a:buffer_number
            return window.winid  " Return window ID if buffer is visible
        endif
    endfor

    return 0  " Return 0 if buffer is not visible
endfunction

function! s:hide_terminal_window(window_id) abort
    call win_execute(a:window_id, 'hide')
endfunction

function! s:show_existing_terminal(buffer_number) abort
    botright split

    execute 'buffer ' . a:buffer_number

    let height = max([10, &lines / 3])
    execute 'resize ' . height

    call feedkeys('i', 'n')
endfunction

function! s:create_new_terminal() abort
    terminal
    
    let height = max([10, &lines / 3])
    execute 'resize ' . height
endfunction

