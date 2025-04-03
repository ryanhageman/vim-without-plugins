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
