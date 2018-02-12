set nocompatible

" VUNDLE BS
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" can't believe im using plugins just for this shit :(
Plugin 'christoomey/vim-tmux-navigator'

" plugin for extra colorschemes
Plugin 'flazz/vim-colorschemes'

" plugin for linting
Plugin 'w0rp/ale'

call vundle#end()
filetype plugin indent on
" VUNDLE BS END

" vim-tmux-navigator config

" saves all vim buffers when switching to tmux pane out of vim split
" set to 1 if you only want to save selected vim split
let g:tmux_navigator_save_on_switch = 2
" vim-tmux-navigator config end

" fzf plugin
" set rtp+=~/.fzf
" fzf plugin end

syntax on
set mouse=a
set hlsearch
colorscheme molokai

set number
set relativenumber

inoremap fd <Esc>
" sets time between f and d to be 200ms
set timeoutlen=200

set tabstop=4
set shiftwidth=4
set expandtab
filetype plugin indent on
" set iskeyword-=_

set t_Co=256

" for ALE linting plugin
let g:ale_linters = {
\   'cpp': ['g++'],
\}
