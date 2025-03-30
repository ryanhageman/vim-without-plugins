" ==========================================================================
" Navigation Settings
" ==========================================================================

" File Navigation
set path+=**

" Buffer Navigation
set hidden

" Netrw settings
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_winsize = 100

function! ToggleNetrw()
  if &filetype == 'netrw'
    Rexplore
  else
    Explore
  endif
endfunction

nnoremap <leader>e :call ToggleNetrw()<cr>
