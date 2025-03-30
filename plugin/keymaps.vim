" ==========================================================================
" Keymaps
" ==========================================================================

" Vim Settings (vimrc)
nnoremap <leader>ve :e $MYVIMRC<cr>

" Buffer
nnoremap <leader>bb :ls<cr>:b |             " list of open buffers
nnoremap <leader>bp :bp<cr>|                " previous buffer
nnoremap <leader>bn :bn<cr>|                " next buffer
nnoremap <leader>bd :bd<cr>|                " delete the buffer

" Files
nnoremap <leader>fs :write<cr>|             " file save (:write)
nnoremap <leader>ff :e|                     " find file 

" Windows
nnoremap <leader>ww <c-w>w                  " Swap Windows
nnoremap <leader>wv <c-w>v                  " Vertical split
nnoremap <leader>ws <c-w>s                  " Horizontal split
nnoremap <leader>wt :term<cr>|              " Open a terminal split
nnoremap <c-j> <c-w><c-j>                   " Move to the window below
nnoremap <c-k> <c-w><c-k>                   " Move to the window above
nnoremap <c-h> <c-w><c-h>                   " Move to the window left
nnoremap <c-l> <c-w><c-l>                   " Move to the window right

" Terminal
nnoremap <leader>' :term<cr>|               " Open a terminal split
