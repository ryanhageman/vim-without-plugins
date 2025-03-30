" Disable vi compatibility
set nocompatible            " Use Vim settings, not Vi

" Set runtime path to include current directory
let s:config_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let &runtimepath = s:config_dir . ',' . &runtimepath

" Setup Leader Keys
nnoremap <space> <nop>
xnoremap <space> <nop>

let mapleader = "\<space>"
let maplocalleader = "\<space>"

inoremap jk <esc>h |              			" escape insert with jk

" Syntax highlighting
syntax on                               " Syntax Highlighting

" Filetypes
filetype plugin indent on               " Filetype detection and language based indenting

" Colors
if has('termguicolors')
  set termguicolors
endif

" Encoding
set encoding=utf-8

" Performance settings
set lazyredraw                          " Don't redraw while running macros
set ttyfast                             " Faster terminal connection
