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
