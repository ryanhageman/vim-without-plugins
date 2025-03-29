" ==========================================================================
" UI Settings
" ==========================================================================

" Colors and themes
set background=dark                 " Use dark background
colorscheme retrobox                " Theme

" Statusline
set laststatus=2                    " Show status line
set showcmd                         " Show partial commands
set showmode                        " Show current mode
set ruler                           " Show cursor position

" Lines
set number                          " Show line numbers
set relativenumber                  " Show relative line numbers

" Visual markers
set showmatch                       " Highlight matching brackets
set matchtime=2                     " Highlight time
set signcolumn=yes                  " Show the sign column

" Cursor shape in different modes
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Window
set title                           " Show file in titlebar
set splitbelow                      " Open new splits below
set splitright                      " Open new vsplits to the right
