" ==========================================================================
" UI Settings
" ==========================================================================

" Colors and themes
set background=dark                 " Use dark background
colorscheme retrobox                " Theme
" colorscheme mardigras               " Theme

" Lines
set number                          " Show line numbers
set relativenumber                  " Show relative line numbers

augroup smart_relative_line_numbers
  autocmd!
  autocmd InsertEnter * set norelativenumber
  autocmd InsertLeave * set relativenumber
augroup END

" Visual markers
set showmatch                       " Highlight matching brackets
set matchtime=2                     " Highlight time
set signcolumn=yes                  " Show the sign column

" Cursor shape in different modes
let &t_SI = "\033[5 q"              " Insert mode: vertical bar
let &t_SR = "\033[3 q"              " Replace mode: underscore
let &t_EI = "\033[1 q"              " Normal mode: block

" Window
set title                           " Show file in titlebar
set splitbelow                      " Open new splits below
set splitright                      " Open new vsplits to the right

