" ==========================================================================
" ERB Settings
" ==========================================================================

" Omnicompletion
let s:full_filetype = &filetype
let s:primary_filetype = split(s:full_filetype, '\.')[0]

if s:primary_filetype == 'html' || s:full_filetype == 'eruby' 
  setlocal omnifunc=htmlcomplete#CompleteTags

elseif s:primary_filetype == 'javascript'
  setlocal omnifunc=javascriptcomplete#CompleteJS

elseif s:primary_filetype == 'css'
  setlocal omnifunc=csscomplete#CompleteCSS

else
  setlocal omnifunc=syntaxcomplete#Complete
endif
