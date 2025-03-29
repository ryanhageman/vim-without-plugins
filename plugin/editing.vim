" ==========================================================================
" Text Editing Settings
" ==========================================================================

" Tabs
set expandtab                " User spaces instead of tabs
set tabstop=2                " A tab is 2 spaces
set shiftwidth=2             " Autoindent size
set softtabstop=2            " Backspace tab removal size
set autoindent               " New lines have the same indent as the last
set smartindent              " Smart autoindenting 

" Enhanced folding appearance
set foldmethod=manual           " Use manual folding by default
set foldtext=CleanFoldText()    " Use custom fold text function

function! CleanFoldText()
  let line = getline(v:foldstart)
  let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')

  return v:folddashes . sub . ' (' . (v:foldend - v:foldstart + 1) . ' lines)'
endfunction

