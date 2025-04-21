" List of common HTML tags to complete
let s:html_tags = [
  \ 'a', 'abbr', 'address', 'article', 'aside', 
  \ 'b', 'blockquote', 'body', 'button',
  \ 'div', 
  \ 'em',
  \ 'footer', 'form',
  \ 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'head', 'header', 'hr', 'html',
  \ 'i', 'iframe', 'img', 'input',
  \ 'label', 'li', 'link',
  \ 'main', 'meta',
  \ 'nav',
  \ 'ol', 'option',
  \ 'p', 'pre',
  \ 'script', 'section', 'select', 'small', 'span', 'strong', 'style',
  \ 'table', 'tbody', 'td', 'textarea', 'tfoot', 'th', 'thead', 'title', 'tr',
  \ 'ul'
  \ ]

" Find HTML tags that match the given prefix
function! s:find_matching_html_tags(prefix)
  let matching_tags = []
  for tag in s:html_tags
    if tag =~ '^' . a:prefix
      " For each matching tag, create a completion item
      let completion_item = {
        \ 'word': tag,
        \ 'abbr': tag,
        \ 'menu': 'HTML Tag',
        \ 'kind': 't',
        \ 'dup': 1,
        \ 'user_data': tag
      \ }
      call add(matching_tags, completion_item)
    endif
  endfor
  return matching_tags
endfunction

" Main HTML tag completion function   
function! htmltag#Complete(findstart, base)
  if a:findstart
    " Find the start of the tag name
    let line = getline('.')
    let start_position = col('.') - 1
    while start_position > 0 && line[start_position - 1] =~ '\a'
      let start_position -= 1
    endwhile
    return start_position
  else
    " Find tags matching with "base"
    return s:find_matching_html_tags(a:base)
  endif
endfunction

" Function to expand a tag into opening and closing tags
function! htmltag#ExpandTag()
  let tag = v:completed_item.user_data
  call feedkeys("\<Esc>ciw<" . tag . ">\<Esc>a</" . tag . ">\<Esc>F>a", 'n')
endfunction

" Setup function to be called from ftplugin files
function! htmltag#Setup()
  " Set up user-defined completion for HTML tags
  setlocal completefunc=htmltag#Complete

  " Set up autocommand to expand tag after completion
  augroup HtmlTagExpansion
    autocmd!
    autocmd CompleteDone * if v:completed_item.menu == 'HTML Tag' |
      \ call htmltag#ExpandTag() |
      \ endif
  augroup END
endfunction

