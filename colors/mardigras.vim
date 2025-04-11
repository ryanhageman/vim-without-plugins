" Mardi Gras Color Scheme for Vim

let g:colors_name = "mardigras"

" {{{ Colors
let s:purple       = '#9B59B6'  " Purple (Flow)
let s:green        = '#2C9741'  " Green (Payload)
let s:gold         = '#FFD700'  " Gold (Meta/Attention)
let s:blue         = '#4188E1'  " Accent Blue
let s:blueComment  = '#6C7D91'  " Muted Blue-Gray for Comments
let s:lavender     = '#D8A7D3'  " Lavender Pink
let s:red          = '#FF4C4C'  " Bright Red
let s:bg           = '#1E101D'  " Background: Deep, Soft Purple
let s:fg           = '#F1E5C9'  " Foreground: Light Cream
let s:lineNr       = '#95A5A6'  " Line Numbers: Gray
let s:cursorLine   = '#34495E'  " Current Line: Muted Blue
let s:statusLineBg = '#2C3E50'  " Status Line Background
" }}}


" {{{ Highlight Function
function! s:hi(group, fg, bg, attr)
  let l:cmd = 'highlight ' . a:group . ' guifg=' . a:fg . ' guibg=' . a:bg
  if a:attr != ''
    let l:cmd .= ' gui=' . a:attr
  endif
  execute l:cmd
endfunction
" }}}


" {{{ Basic Syntax Tokens
" Background and Foreground
call s:hi("Normal", s:fg, s:bg, "")
call s:hi("NonText", s:bg, s:bg, "")

" Purple (Flow) for Keywords, Control Flow
call s:hi("Keyword", s:purple, s:bg, "")
call s:hi("Statement", s:purple, s:bg, "")
call s:hi("Type", s:purple, s:bg, "")
call s:hi("TypeDef", s:purple, s:bg, "")
call s:hi("Function", s:purple, s:bg, "")
call s:hi("Boolean", s:purple, s:bg, "")
call s:hi("Conditional", s:purple, s:bg, "")
call s:hi("Label", s:purple, s:bg, "")

" Green (Payload) for Variables, Functions, Strings
call s:hi("Identifier", s:green, s:bg, "")
call s:hi("String", s:green, s:bg, "")
call s:hi("Number", s:green, s:bg, "")
call s:hi("Function", s:green, s:bg, "")
call s:hi("Constant", s:green, s:bg, "")
call s:hi("Variable", s:green, s:bg, "")
call s:hi("StringDelimiter", s:green, s:bg, "")
call s:hi("Operator", s:green, s:bg, "")

" Gold (Meta/Attention) for Comments, TODOs, etc.
call s:hi("Comment", s:gold, s:bg, "italic")
call s:hi("Todo", s:gold, s:bg, "bold")
call s:hi("Label", s:gold, s:bg, "")
call s:hi("Special", s:gold, s:bg, "")
call s:hi("FunctionCall", s:gold, s:bg, "")
call s:hi("SpecialChar", s:gold, s:bg, "")

" Accent Blue for Inactive/Unused Code, Search Results
call s:hi("Comment", s:blueComment, s:bg, "")
call s:hi("Search", s:blue, s:bg, "reverse")
call s:hi("IncSearch", s:blue, s:bg, "reverse")
call s:hi("PreProc", s:blue, s:bg, "")
call s:hi("Include", s:blue, s:bg, "")
call s:hi("StorageClass", s:blue, s:bg, "")

" Lavender Pink for Faded/Inactivate Code
call s:hi("Constant", s:lavender, s:bg, "")
call s:hi("Special", s:lavender, s:bg, "")

" Bright Red for Errors and Critical Warnings
call s:hi("Error", s:red, s:bg, "bold")
call s:hi("Warning", s:red, s:bg, "")

" Line Numbering (Neutral)
call s:hi("LineNr", s:lineNr, s:bg, "")
call s:hi("CursorLineNr", s:lineNr, s:bg, "")

" Current Line Highlighting
call s:hi("CursorLine", s:fg, s:cursorLine, "bold")

" Status Line (Neutral)
call s:hi("StatusLine", s:fg, s:statusLineBg, "bold")
call s:hi("StatusLineNC", s:lineNr, s:statusLineBg, "")
" }}}

