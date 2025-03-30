" mardigras.vim - A Mardi Gras inspired colorscheme with Gruvbox's soft approach
" Author: Created with Claude
" Description: Authentic Mardi Gras colors with a soft, easy-on-the-eyes background

" Reset syntax highlighting
hi clear
if exists("syntax_on")
  syntax reset
endif

" Set name of the theme
let g:colors_name = "mardigras"

" Define colors
let s:bg          = "#2A2438"    " Dark purple-tinted background
let s:bg_soft     = "#352D45"    " Slightly lighter background for visual distinction
let s:bg_darker   = "#221D2E"    " Darker background for special elements
let s:fg          = "#D8D0C1"    " Softer, warmer white for normal text
let s:comment     = "#7D6E8B"    " Muted purple-gray for comments

" Mardi Gras authentic colors (slightly adjusted for readability)
let s:purple      = "#A277FF"    " Justice (keywords, tags)
let s:green       = "#40A02B"    " Faith (strings)
let s:gold        = "#F5C211"    " Power (functions, constants, numbers)

" Supporting colors
let s:light_purple = "#CBA6F7"   " Light purple for special identifiers
let s:soft_orange  = "#F8BD96"   " Soft orange for attributes/parameters
let s:error_red    = "#F38BA8"   " Error highlighting
let s:warning      = "#FAB387"   " Warning highlighting
let s:diff_add     = "#40A02B"   " Added lines in diffs
let s:diff_change  = "#CBA6F7"   " Changed lines in diffs
let s:diff_delete  = "#F38BA8"   " Deleted lines in diffs

" Command to set highlighting
function! s:hi(group, fg, bg, attr)
  if a:fg != ""
    exec "hi " . a:group . " guifg=" . a:fg
  endif
  if a:bg != ""
    exec "hi " . a:group . " guibg=" . a:bg
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr
  endif
endfunction

" Terminal colors
if has('nvim')
  let g:terminal_color_0  = s:bg
  let g:terminal_color_1  = s:error_red
  let g:terminal_color_2  = s:green
  let g:terminal_color_3  = s:gold
  let g:terminal_color_4  = s:purple
  let g:terminal_color_5  = s:light_purple
  let g:terminal_color_6  = s:soft_orange
  let g:terminal_color_7  = s:fg
  let g:terminal_color_8  = s:bg_soft
  let g:terminal_color_9  = s:error_red
  let g:terminal_color_10 = s:green
  let g:terminal_color_11 = s:gold
  let g:terminal_color_12 = s:purple
  let g:terminal_color_13 = s:light_purple
  let g:terminal_color_14 = s:soft_orange
  let g:terminal_color_15 = s:fg
endif

" General UI
call s:hi("Normal", s:fg, s:bg, "")
call s:hi("LineNr", s:bg_soft, "", "")
call s:hi("CursorLineNr", s:gold, "", "bold")
call s:hi("CursorLine", "", s:bg_soft, "")
call s:hi("CursorColumn", "", s:bg_soft, "")
call s:hi("SignColumn", "", s:bg, "")
call s:hi("ColorColumn", "", s:bg_soft, "")
call s:hi("VertSplit", s:bg_soft, s:bg, "")
call s:hi("Folded", s:comment, s:bg_soft, "")
call s:hi("FoldColumn", s:comment, s:bg, "")
call s:hi("Pmenu", s:fg, s:bg_soft, "")
call s:hi("PmenuSel", s:bg, s:purple, "")
call s:hi("PmenuSbar", "", s:bg_soft, "")
call s:hi("PmenuThumb", "", s:fg, "")
call s:hi("StatusLine", s:fg, s:bg_soft, "")
call s:hi("StatusLineNC", s:comment, s:bg_soft, "")
call s:hi("Search", s:bg, s:gold, "")
call s:hi("IncSearch", s:bg, s:gold, "")
call s:hi("Question", s:green, "", "")
call s:hi("MatchParen", s:bg, s:gold, "bold")
call s:hi("Visual", "", s:bg_soft, "")
call s:hi("VisualNOS", "", s:bg_soft, "")
call s:hi("NonText", s:comment, "", "")
call s:hi("Todo", s:gold, s:bg_soft, "bold")
call s:hi("Error", s:error_red, "", "bold")
call s:hi("ErrorMsg", s:error_red, s:bg, "bold")
call s:hi("WarningMsg", s:warning, s:bg, "")
call s:hi("SpecialKey", s:comment, "", "")
call s:hi("Directory", s:purple, "", "")
call s:hi("Title", s:green, "", "bold")
call s:hi("WildMenu", s:bg, s:gold, "")

" Diff highlighting
call s:hi("DiffAdd", "", s:diff_add, "")
call s:hi("DiffChange", "", s:diff_change, "")
call s:hi("DiffDelete", "", s:diff_delete, "")
call s:hi("DiffText", s:fg, s:diff_change, "bold")

" Syntax highlighting groups for various languages
" General syntax groups
call s:hi("Comment", s:comment, "", "italic")
call s:hi("Constant", s:gold, "", "")
call s:hi("String", s:green, "", "")
call s:hi("Character", s:green, "", "")
call s:hi("Number", s:gold, "", "")
call s:hi("Boolean", s:gold, "", "bold")
call s:hi("Float", s:gold, "", "")
call s:hi("Identifier", s:fg, "", "")
call s:hi("Function", s:gold, "", "")
call s:hi("Statement", s:purple, "", "bold")
call s:hi("Conditional", s:purple, "", "bold")
call s:hi("Repeat", s:purple, "", "bold")
call s:hi("Label", s:purple, "", "")
call s:hi("Operator", s:soft_orange, "", "")
call s:hi("Keyword", s:purple, "", "bold")
call s:hi("Exception", s:purple, "", "bold")
call s:hi("PreProc", s:light_purple, "", "")
call s:hi("Include", s:light_purple, "", "")
call s:hi("Define", s:light_purple, "", "")
call s:hi("Macro", s:light_purple, "", "")
call s:hi("PreCondit", s:light_purple, "", "")
call s:hi("Type", s:soft_orange, "", "bold")
call s:hi("StorageClass", s:soft_orange, "", "bold")
call s:hi("Structure", s:soft_orange, "", "bold")
call s:hi("Typedef", s:soft_orange, "", "bold")
call s:hi("Special", s:light_purple, "", "")
call s:hi("SpecialChar", s:light_purple, "", "")
call s:hi("Tag", s:purple, "", "")
call s:hi("Delimiter", s:fg, "", "")
call s:hi("SpecialComment", s:comment, "", "bold")
call s:hi("Debug", s:error_red, "", "")
call s:hi("Underlined", s:fg, "", "underline")
call s:hi("Ignore", s:comment, "", "")

" Ruby specific
call s:hi("rubyClass", s:purple, "", "bold")
call s:hi("rubyModule", s:purple, "", "bold")
call s:hi("rubyDefine", s:purple, "", "bold")
call s:hi("rubySymbol", s:gold, "", "")
call s:hi("rubyInterpolation", s:green, "", "")
call s:hi("rubyStringDelimiter", s:green, "", "")
call s:hi("rubyBlockParameter", s:soft_orange, "", "")
call s:hi("rubyInstanceVariable", s:light_purple, "", "")
call s:hi("rubyInclude", s:purple, "", "")
call s:hi("rubyGlobalVariable", s:error_red, "", "")
call s:hi("rubyRegexp", s:green, "", "")
call s:hi("rubyRegexpDelimiter", s:green, "", "")
call s:hi("rubyEscape", s:gold, "", "")
call s:hi("rubyControl", s:purple, "", "bold")
call s:hi("rubyClassVariable", s:soft_orange, "", "")
call s:hi("rubyOperator", s:purple, "", "")
call s:hi("rubyException", s:purple, "", "bold")
call s:hi("rubyPseudoVariable", s:purple, "", "italic")
call s:hi("rubyRailsUserClass", s:soft_orange, "", "")
call s:hi("rubyRailsARAssociationMethod", s:gold, "", "")
call s:hi("rubyRailsARMethod", s:gold, "", "")
call s:hi("rubyRailsRenderMethod", s:gold, "", "")
call s:hi("rubyRailsMethod", s:gold, "", "")
call s:hi("rubyMethodName", s:gold, "", "")
call s:hi("rubyMethodCall", s:gold, "", "")

" HTML/ERB specific
call s:hi("htmlTag", s:purple, "", "")
call s:hi("htmlEndTag", s:purple, "", "")
call s:hi("htmlTagName", s:purple, "", "bold")
call s:hi("htmlArg", s:soft_orange, "", "")
call s:hi("htmlSpecialChar", s:gold, "", "")
call s:hi("erubyDelimiter", s:error_red, "", "")
call s:hi("erubyComment", s:comment, "", "italic")

" CSS/SCSS specific
call s:hi("cssURL", s:soft_orange, "", "underline")
call s:hi("cssFunctionName", s:gold, "", "")
call s:hi("cssColor", s:gold, "", "")
call s:hi("cssPseudoClassId", s:purple, "", "")
call s:hi("cssClassName", s:purple, "", "bold")
call s:hi("cssValueLength", s:gold, "", "")
call s:hi("cssCommonAttr", s:gold, "", "")
call s:hi("cssBraces", s:fg, "", "")
call s:hi("cssIdentifier", s:purple, "", "bold")
call s:hi("cssIncludeKeyword", s:purple, "", "bold")
call s:hi("cssUnitDecorators", s:soft_orange, "", "")
call s:hi("scssSelectorName", s:purple, "", "bold")
call s:hi("scssVariable", s:light_purple, "", "")

" JavaScript specific
call s:hi("javaScriptBraces", s:fg, "", "")
call s:hi("javaScriptFunction", s:purple, "", "bold")
call s:hi("javaScriptIdentifier", s:purple, "", "")
call s:hi("javaScriptMember", s:gold, "", "")
call s:hi("javaScriptNumber", s:gold, "", "")
call s:hi("javaScriptNull", s:gold, "", "bold")
call s:hi("javaScriptParens", s:fg, "", "")
call s:hi("javascriptImport", s:purple, "", "bold")
call s:hi("javascriptExport", s:purple, "", "bold")
call s:hi("javascriptClassKeyword", s:purple, "", "bold")
call s:hi("javascriptClassExtends", s:purple, "", "bold")
call s:hi("javascriptDefault", s:purple, "", "bold")
call s:hi("javascriptClassName", s:soft_orange, "", "bold")
call s:hi("javascriptClassSuperName", s:soft_orange, "", "")
call s:hi("javascriptGlobal", s:soft_orange, "", "")
call s:hi("javascriptEndColons", s:fg, "", "")
call s:hi("javascriptFuncArg", s:fg, "", "")
call s:hi("javascriptGlobalMethod", s:gold, "", "")
call s:hi("javascriptNodeGlobal", s:light_purple, "", "")
call s:hi("javascriptBOMWindowProp", s:light_purple, "", "")
call s:hi("javascriptArrayMethod", s:gold, "", "")
call s:hi("javascriptArrayStaticMethod", s:gold, "", "")
call s:hi("javascriptCacheMethod", s:gold, "", "")
call s:hi("javascriptDateMethod", s:gold, "", "")
call s:hi("javascriptMathStaticMethod", s:gold, "", "")
call s:hi("javascriptURLUtilsProp", s:light_purple, "", "")
call s:hi("javascriptProp", s:light_purple, "", "")
call s:hi("javascriptPromiseMethod", s:gold, "", "")
call s:hi("javascriptPromiseStaticMethod", s:gold, "", "")
call s:hi("javascriptReflectMethod", s:gold, "", "")
call s:hi("javascriptRegexpMethod", s:gold, "", "")
call s:hi("javascriptRegexp", s:green, "", "")
call s:hi("javascriptStringMethod", s:gold, "", "")
call s:hi("javascriptVariable", s:purple, "", "")
call s:hi("javascriptArrowFunc", s:gold, "", "")
call s:hi("javascriptTemplate", s:green, "", "")
call s:hi("javascriptTemplateSB", s:light_purple, "", "")

" Markdown specific
call s:hi("markdownHeadingDelimiter", s:purple, "", "bold")
call s:hi("markdownH1", s:purple, "", "bold")
call s:hi("markdownH2", s:purple, "", "bold")
call s:hi("markdownH3", s:purple, "", "bold")
call s:hi("markdownH4", s:purple, "", "bold")
call s:hi("markdownH5", s:purple, "", "bold")
call s:hi("markdownH6", s:purple, "", "bold")
call s:hi("markdownCode", s:green, "", "")
call s:hi("markdownCodeBlock", s:green, "", "")
call s:hi("markdownCodeDelimiter", s:green, "", "")
call s:hi("markdownBlockquote", s:comment, "", "")
call s:hi("markdownListMarker", s:gold, "", "bold")
call s:hi("markdownOrderedListMarker", s:gold, "", "bold")
call s:hi("markdownRule", s:comment, "", "")
call s:hi("markdownHeadingRule", s:comment, "", "")
call s:hi("markdownUrlDelimiter", s:fg, "", "")
call s:hi("markdownLinkDelimiter", s:fg, "", "")
call s:hi("markdownLinkTextDelimiter", s:fg, "", "")
call s:hi("markdownHeadingDelimiter", s:gold, "", "")
call s:hi("markdownUrl", s:soft_orange, "", "underline")
call s:hi("markdownUrlTitleDelimiter", s:green, "", "")
call s:hi("markdownLinkText", s:purple, "", "underline")
call s:hi("markdownIdDeclaration", s:purple, "", "")

" YAML specific
call s:hi("yamlKey", s:purple, "", "bold")
call s:hi("yamlAnchor", s:light_purple, "", "")
call s:hi("yamlAlias", s:light_purple, "", "")
call s:hi("yamlDocumentHeader", s:green, "", "")

" Vimscript specific
call s:hi("vimFunction", s:gold, "", "")

" Must be at the end, because of ctermbg=234 bug.
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
