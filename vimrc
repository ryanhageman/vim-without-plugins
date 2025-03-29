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

" Syntax highlighting
syntax on

" Filetypes
filetype plugin indent on

" Colors
if has('termguicolors')
  set termguicolors
endif

" Encoding
set encoding=utf-8

