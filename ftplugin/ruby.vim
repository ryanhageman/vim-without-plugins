" ==========================================================================
" Ruby Settings
" ==========================================================================

" Indentation settings
setlocal expandtab                                  " Use spaces instead of tabs
setlocal tabstop=2                                  " A tab is 2 spaces
setlocal shiftwidth=2                               " Number of spaces to use for autoindent
setlocal softtabstop=2                              " When hitting <BS>, pretend a tab is removed
setlocal autoindent                                 " Copy indent from current line when starting a new line
setlocal nosmartindent                              " Skip this, we've got more specific stuff here

" Standard Ruby (standard.rb) indentation settings
let g:ruby_indent_access_modifier_style = 'normal'  " Align methods with access modifiers
let g:ruby_indent_assignment_style = 'hanging'      " Indent values after assignment
let g:ruby_indent_block_style = 'expression'        " Indent blocks based on containing expression
let g:ruby_indent_hanging_elements = 1              " Indent elements in multi-line arrays/hashes
let g:ruby_indent_when_to_case = 1                  " Align 'when' with 'case' (Standard Ruby style)
let g:ruby_indent_case_style = 'normal'             " Indent case bodies

" Folding
setlocal foldmethod=syntax                          " Fold using syntax analysis
setlocal nofoldenable                               " Open the file open, no autofolding

" -- Omnicompletion --------------------------------------------------------
setlocal omnifunc=rubycomplete#Complete

" Use stuff in the current buffer
if !exists('g:rubycomplete_classes_in_global')
  let g:rubycomplete_classes_in_global = 1
endif

" Include Rails support
if !exists('g:rubycomplete_rails')
  let g:rubycomplete_rails = 1
endif

" Completion menu options
setlocal completeopt=menu,menuone,noselect,noinsert,preview

" --------------------------------------------------------------------------

" Rails Navigation Plugin
call rails_navigation#setup()
