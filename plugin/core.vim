" ==========================================================================
" Core Settings
" ==========================================================================

" General Behavior
set hidden                      " Allow switching buffers without saving

" Backup and Swap files
set nobackup                    " Skip making backup files
set nowritebackup               " Skip making backups when writing
set noswapfile                  " Skip making swap files

" Mouse
set mouse=a

" Command Line Completion
set wildmenu                    " Command Line completion menu
set wildmode=longest:full,full  " Longest match first, then cycle
set wildoptions=pum		" Completions in a popup menu
set pumheight=10                " Completion menu height


" Enhanced folding appearance
set foldmethod=manual           " Use manual folding by default
set foldtext=CleanFoldText()    " Use custom fold text function

function! CleanFoldText()
  let line = getline(v:foldstart)
  let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')

  return v:folddashes . sub . ' (' . (v:foldend - v:foldstart + 1) . ' lines)'
endfunction

