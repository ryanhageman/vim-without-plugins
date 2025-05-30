" ==========================================================================
" Vimscript Settings
" ==========================================================================

" Indentation settings
setlocal expandtab               " Use spaces instead of tabs
setlocal tabstop=2               " A tab is 2 spaces
setlocal shiftwidth=2            " Number of spaces to use for autoindent
setlocal softtabstop=2           " When hitting <BS>, pretend a tab is removed

" Wrapping
setlocal textwidth=80            " Maximum width for formatting with gq
setlocal formatoptions-=t        " Disable auto-wrap text using textwidth
setlocal formatoptions+=c        " Auto-wrap comments using textwidth when adding text
setlocal formatoptions+=q        " Allow formatting of comments with gq
setlocal formatoptions+=j        " Remove comment leader when joining lines

" Folding
setlocal foldmethod=marker
setlocal foldmarker={{{,}}}
setlocal nofoldenable

" Omnifunc
setlocal omnifunc=syntaxcomplete#Complete

" Snippets
iabbrev xline " ---------------------------------------------------------------------------

