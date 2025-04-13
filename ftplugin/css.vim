" ==========================================================================
" CSS Settings
" ==========================================================================

" Indentation settings
setlocal expandtab               " Use spaces instead of tabs
setlocal tabstop=2               " A tab is 2 spaces
setlocal shiftwidth=2            " Number of spaces to use for autoindent
setlocal softtabstop=2           " When hitting <BS>, pretend a tab is removed
setlocal autoindent              " Copy indent from current line when starting a new line
setlocal smartindent             " Skip this, we've got more specific stuff here

" Wrapping
setlocal textwidth=80            " Maximum width for formatting with gq
setlocal formatoptions-=t        " Disable auto-wrap text using textwidth
setlocal formatoptions+=c        " Auto-wrap comments using textwidth when adding text
setlocal formatoptions+=q        " Allow formatting of comments with gq
setlocal formatoptions+=j        " Remove comment leader when joining lines
setlocal formatoptions+=r        " Auto-insert comment leader after <Enter>
setlocal formatoptions+=o        " Auto-insert comment leader after o or O

" Folding
setlocal foldmethod=syntax       " Fold using syntax analysis
setlocal nofoldenable            " Open the file open, no autofolding

" Matching
setlocal matchpairs+=<:>         " Add angle brackets to matching pairs

" -- Omnicompletion --------------------------------------------------------
setlocal omnifunc=csscomplete#CompleteCSS

" Completion menu options
setlocal completeopt=menu,menuone,noselect,noinsert,preview

" ---------------------------------------------------------------------------
