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

set statusline=
set statusline+=%{%StatusLine_Left_End()%}
set statusline+=%{StatusLine_CurrentMode()}
set statusline+=%{StatusLine_Divider()}
set statusline+=%{%StatusLine_Filename()%}
set statusline+=%{StatusLine_Divider()}
set statusline+=%{%StatusLine_CursorPosition()%}
set statusline+=%{StatusLine_Divider()}
set statusline+=%{%StatusLine_OtherBufferInfo()%}
set statusline+=%=
set statusline+=%{%StatusLine_CurrentTime()%}
set statusline+=%{StatusLine_Divider()}
set statusline+=%{StatusLine_GitBranch()}
set statusline+=%{StatusLine_Right_End()}

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

function! StatusLine_Filename() abort
  return s:short_file_path () . s:modified_icon()
endfunction

function! StatusLine_CursorPosition() abort
  return "(%l/%c) %p%%"
endfunction

function! StatusLine_OtherBufferInfo() abort
  return "%h%r"
endfunction

function! StatusLine_CurrentTime() abort
  return strftime('%A %b %d - %I:%M %p')
endfunction

function! StatusLine_GitBranch() abort
  return s:current_git_branch()
endfunction

" --------------------------------------------------------------------------

function! s:short_file_path() abort
  let path = expand('%:~:.')
  return path =~# '^\[No Name\]$' ? '[No Name]' : path
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
