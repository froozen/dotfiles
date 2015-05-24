"
" ~/.vimrc
"

set nocompatible
filetype off

" Plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" General
Plugin 'gmarik/Vundle.vim'
Plugin 'Sirver/ultisnips'
Plugin 'bling/vim-airline'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'scrooloose/syntastic'

" Go plugins
Plugin 'fatih/vim-go'

" C / C++ plugins
Plugin 'Valloric/YouCompleteMe'
Plugin 'FSwitch'
Plugin 'octol/vim-cpp-enhanced-highlight'

" Haskell plugins
Plugin 'bitc/vim-hdevtools'

call vundle#end()

map , <Nop>
let mapleader = ","
" Fix Backspace
set backspace=2

" General
nnoremap <silent> <Leader>w :w<CR>
nnoremap <silent> <Leader>W :wq<CR>
nnoremap <silent> <Leader>q :q<CR>

" FSwitch
nnoremap <silent> <Leader>ff :FSHere<CR>
nnoremap <silent> <Leader>fl :FSRight<CR>
nnoremap <silent> <Leader>fh :FSLeft<CR>
nnoremap <silent> <Leader>fL :FSSplitRight<CR>
nnoremap <silent> <Leader>fH :FSSplitLeft<CR>

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-e>"
let g:UltiSnipsEditSplit="vertical"

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_complete_in_comments=1

" vim-go
" TODO Change to compter specific path
let $GOPATH='/home/fro_ozen/Coding/go'
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_def_mapping_enabled = 0

" Don't show tabs with listchars in go
augroup go_augroup
    autocmd!
    autocmd FileType go setlocal listchars=tab:\ \ ,trail:.
augroup END

" hdevtools
nnoremap <silent> <Leader>hh :HdevtoolsType<CR>
nnoremap <silent> <Leader>hc :HdevtoolsClear<CR>
nnoremap <silent> <Leader>hi :HdevtoolsInfo<CR>

" syntastic
nnoremap <silent> <Leader>e :Errors<CR>

" Airline
let g:bufferline_echo = 0
let g:airline_powerline_fonts=1
set laststatus=2

" General vim configuration
syntax on
filetype plugin indent on
set number
set relativenumber
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set listchars=tab:>-,trail:.
set list
set wildmenu
set cursorline

filetype indent on

colorscheme molokai

" Use tabs for makefile indenting
autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0

" Accept .md files as markdown
autocmd BufEnter *.md setlocal ft=markdown

" Make gvim usable
if has ( 'gui_running' )
    set guifont=Tewi\ 9
    " Disable a lot of useless stuff
    set go-=m
    set go-=T
    set go-=r
    set go-=L

    " Reenable traditional dialouges
    set go+=c
endif
