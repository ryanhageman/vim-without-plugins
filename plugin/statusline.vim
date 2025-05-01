" ==========================================================================
" Status Line  
" ==========================================================================

let s:READABLE_MODE_NAMES={
  \ 'n'      : 'NORMAL',
  \ 'no'     : 'NORMAL,OP',
  \ 'nov'    : 'NORMAL,OP,CHAR',
  \ 'noV'    : 'NORMAL,OP,LINE',
  \ 'no^V'   : 'NORMAL,OP,BLOCK',
  \ 'niI'    : 'NORMAL,INSERT',
  \ 'niR'    : 'NORMAL,REPLACE',
  \ 'niV'    : 'NORMAL,VREPLACE',
  \ 'v'      : 'VISUAL',
  \ 'V'      : 'V-LINE',
  \ '^V'     : 'V-BLOCK',
  \ 'vs'     : 'VISUAL,SELECT',
  \ 'Vs'     : 'V-LINE,SELECT',
  \ '^Vs'    : 'V-BLOCK,SELECT',
  \ 'vo'     : 'VISUAL,OP',
  \ 'Vo'     : 'V-LINE,OP',
  \ '^Vo'    : 'V-BLOCK,OP',
  \ 's'      : 'SELECT',
  \ 'S'      : 'S-LINE',
  \ '^S'     : 'S-BLOCK',
  \ 'i'      : 'INSERT',
  \ 'ic'     : 'INSERT,COMPL',
  \ 'ix'     : 'INSERT,COMPL',
  \ 'R'      : 'REPLACE',
  \ 'Rc'     : 'REPLACE,COMPL',
  \ 'Rx'     : 'REPLACE,COMPL',
  \ 'Rv'     : 'V-REPLACE',
  \ 'Rvc'    : 'V-REPLACE,COMPL',
  \ 'Rvx'    : 'V-REPLACE,COMPL',
  \ 'c'      : 'COMMAND',
  \ 'cv'     : 'VIM EX',
  \ 'ce'     : 'EX',
  \ 'cr'     : 'CMD,PROMPT',
  \ 'r'      : 'PROMPT',
  \ 'rm'     : 'MORE',
  \ 'r?'     : 'CONFIRM',
  \ '!'      : 'SHELL',
  \ 't'      : 'TERMINAL',
  \ 'nt'     : 'NORMAL,TERM',
  \ 'it'     : 'INSERT,TERM',
  \ 'vt'     : 'VISUAL,TERM',
  \ 'Vt'     : 'V-LINE,TERM',
  \ '^Vt'    : 'V-BLOCK,TERM',
  \ 'st'     : 'SELECT,TERM',
  \ 'St'     : 'S-LINE,TERM',
  \ '^St'    : 'S-BLOCK,TERM',
  \ 'Rt'     : 'REPLACE,TERM',
  \ 'ct'     : 'COMMAND,TERM',
  \ 'cwt'    : 'CMD-WIN,TERM',
  \ 'rec'    : 'RECORDING',
  \ 'cw'     : 'COMMAND-WIN',
  \ 'sm'     : 'SHOWMATCH'
  \}

lockvar s:READABLE_MODE_NAMES

" --------------------------------------------------------------------------

set laststatus=2
set showcmd
set noshowmode

function! StatusLine_Wide() abort
  let l:statusline = ""
  let l:statusline .= "%{%StatusLine_Left_End()%}"
  let l:statusline .= StatusLine_ModeColor()
  let l:statusline .= "%{StatusLine_CurrentMode()}"
  let l:statusline .= "%#StatusLine#"
  let l:statusline .= "%{StatusLine_Divider()}"
  let l:statusline .= "%{%StatusLine_FileAndPath()%}"
  let l:statusline .= "%{StatusLine_Divider()}"
  let l:statusline .= "%{%StatusLine_CursorPosition()%}"
  let l:statusline .= "%{StatusLine_Divider()}"
  let l:statusline .= "%{%StatusLine_OtherBufferInfo()%}"
  let l:statusline .= "%="
  let l:statusline .= "%{%StatusLine_CurrentDateTime()%}"
  let l:statusline .= "%{StatusLine_Divider()}"
  let l:statusline .= "%{StatusLine_GitBranch()}"
  let l:statusline .= "%{StatusLine_Right_End()}"

  return l:statusline
endfunction

function! StatusLine_Narrow() abort
  let l:statusline = ""
  let l:statusline .= "%{%StatusLine_Left_End()%}"
  let l:statusline .= StatusLine_ModeColor()
  let l:statusline .= "%{StatusLine_CurrentMode()}"
  let l:statusline .= "%#StatusLine#"
  let l:statusline .= "%{StatusLine_Divider()}"
  let l:statusline .= "%{%StatusLine_Filename()%}"
  let l:statusline .= "%{StatusLine_Divider()}"
  let l:statusline .= "%{%StatusLine_CursorPosition()%}"
  let l:statusline .= "%{StatusLine_Divider()}"
  let l:statusline .= "%{%StatusLine_OtherBufferInfo()%}"
  let l:statusline .= "%="
  let l:statusline .= "%{%StatusLine_CurrentTime()%}"
  let l:statusline .= "%{StatusLine_Right_End()}"

  return l:statusline
endfunction

" --------------------------------------------------------------------------

function! StatusLine_Divider() abort
  return "  | "
endfunction

function! StatusLine_Left_End() abort
  return '   '
endfunction

function! StatusLine_Right_End() abort
  return '   '
endfunction

function! StatusLine_CurrentMode() abort
  return get(s:READABLE_MODE_NAMES, mode(), mode())
endfunction

function! StatusLine_FileAndPath() abort
  return s:short_file_path () . s:modified_icon()
endfunction

function! StatusLine_Filename() abort
  return s:filename() . s:modified_icon()
endfunction

function! StatusLine_CursorPosition() abort
  return "(%l/%c) %p%%"
endfunction

function! StatusLine_OtherBufferInfo() abort
  return "%h%r"
endfunction

function! StatusLine_CurrentDateTime() abort
  return strftime('%A %b %d - %I:%M %p')
endfunction

function! StatusLine_CurrentTime() abort
  return strftime('%I:%M %p')
endfunction

function! StatusLine_GitBranch() abort
  return s:current_git_branch()
endfunction

function! StatusLine_AdjustWidth() abort
  let width = winwidth(0)

  if width > 80
    setlocal statusline=%!StatusLine_Wide()
  else 
    setlocal statusline=%!StatusLine_Narrow()
  endif
endfunction

augroup StatusLineAdjust
  autocmd!
  autocmd WinEnter,VimResized * call StatusLine_AdjustWidth()
  autocmd BufWinEnter * call StatusLine_AdjustWidth()
augroup END

call StatusLine_AdjustWidth()

" --------------------------------------------------------------------------

function! s:short_file_path() abort
  let l:path = expand('%:~:.')
  return l:path =~# '^\[No Name\]$' ? '[No Name]' : path
endfunction

function! s:filename() abort
  let l:filename = expand('%:t')
  return l:filename =~# '^\s*$' ? '[No Name]' : filename
endfunction

function! s:modified_icon() abort
  return getbufvar('%', '&modified') ? " 🏄" : "  "
endfunction

" -- Git Branch ------------------------------------------------------------

function! s:current_git_branch() abort
  let l:git_dir = s:find_git_directory(getcwd())

  if empty(l:git_dir)
    return ''
  endif

  " Holds the coordinates to the current position of HEAD
  let l:head_position_file = l:git_dir . '/HEAD'

  if !filereadable(l:head_position_file)
    return ''
  endif

  return '🧪 ' . s:git_branch_name(l:head_position_file)
endfunction

function! s:find_git_directory(start_path) abort
  let l:path = a:start_path

  while l:path !=# '/'
    if s:is_git_directory(l:path)
      return l:path . '/.git'
    endif

    if s:is_git_file(l:path)
      let l:git_dir = s:get_git_dir_from_file(l:path)

      if !empty(l:git_dir)
        return l:git_dir
      endif
    endif

    let l:path = fnamemodify(l:path, ':h')
  endwhile

  return ''
endfunction

" --------------------------------------------------------------------------

function! s:is_git_directory(path) abort
  return isdirectory(a:path . '/.git')
endfunction

function! s:is_git_file(path) abort
  return filereadable(a:path . '/.git')
endfunction

function! s:get_git_dir_from_file(path) abort
  let l:gitfile = readfile(a:path . '/.git', '', 1)

  if !empty(l:gitfile) && l:gitfile[0] =~# '^gitdir: '
    return substitute(l:gitfile[0], '^gitdir: ', '', '')
  endif

  return ''
endfunction

function! s:git_branch_name(head_position_file) abort
  let l:first_line = readfile(a:head_position_file, '', 1)[0]

  if l:first_line =~# '^ref: '
    return substitute(l:first_line, 'ref: refs/heads/', '', '')
  else
    return strpart(l:first_line, 0, 7)
  endif
endfunction

" -- Color Modes ------------------------------------------------------------

function! StatusLine_ModeColor() abort
  return '%#' . s:mode_highlight_group() . '#'
endfunction

function! s:mode_highlight_group() abort
  let l:mode = mode()

  if l:mode =~# '^n'  " Normal modes
    return 'StatusLineMode_Normal'
  elseif l:mode =~# '^i' || l:mode =~# '^niI'  " Insert modes
    return 'StatusLineMode_Insert'
  elseif l:mode =~# '^v' || l:mode =~# '^V' || l:mode =~# '\^V'  " Visual modes
    return 'StatusLineMode_Visual'
  elseif l:mode =~# '^R' || l:mode =~# '^niR'  " Replace modes
    return 'StatusLineMode_Replace'
  elseif l:mode =~# '^c' || l:mode =~# '^r' || l:mode ==# '!'  " Command/prompt modes
    return 'StatusLineMode_Command'
  elseif l:mode =~# 't'  " Terminal modes
    return 'StatusLineMode_Terminal'
  else  " Other modes
    return 'StatusLine'
  endif
endfunction

function! s:get_statusline_background() abort
  let l:cterm_background = synIDattr(synIDtrans(hlID('StatusLine')), 'bg', 'cterm')
  let l:gui_background = synIDattr(synIDtrans(hlID('StatusLine')), 'bg', 'gui')

  return {
    \ 'cterm': l:cterm_background,
    \ 'gui': l:gui_background
    \}
endfunction

function! s:define_mode_highlight_groups() abort
  let l:bg = s:get_statusline_background()

  execute 'highlight StatusLineMode_Normal    guifg=#b8bb26 guibg=#504945 gui=bold,reverse'
  execute 'highlight StatusLineMode_Insert    guifg=#83a598 guibg=#504945 gui=bold,reverse'
  execute 'highlight StatusLineMode_Visual    guifg=#d3869b guibg=#504945 gui=bold,reverse'
  execute 'highlight StatusLineMode_Replace   guifg=#fb4934 guibg=#504945 gui=bold,reverse'
  execute 'highlight StatusLineMode_Command   guifg=#fabd2f guibg=#504945 gui=bold,reverse'
  execute 'highlight StatusLineMode_Terminal  guifg=#8ec07c guibg=#504945 gui=bold,reverse'
endfunction

augroup StatusLineColors
  autocmd!
  autocmd VimEnter,ColorScheme * call s:define_mode_highlight_groups()
augroup END

call s:define_mode_highlight_groups()
