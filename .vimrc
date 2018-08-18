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

" plugin for ctags structure
Plugin 'majutsushi/tagbar'

" plugin for indent guides
Plugin 'Yggdroot/indentLine'

" plugin for commenting
Plugin 'scrooloose/nerdcommenter'

" plugin for repeating plugin functions
Plugin 'tpope/vim-repeat'

" plugin to extend fzf's vim capabilities
Plugin 'junegunn/fzf.vim'
"
" plugin to add git commands to vim
Plugin 'tpope/vim-fugitive'

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
set rtp+=/usr/local/opt/fzf
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
set backspace=2
" set iskeyword-=_

set t_Co=256

" for ALE linting plugin
let g:ale_linters = {
\   'cpp': ['g++'],
\   'python': ['flake8'],
\   'javascript': ['eslint'],
\   'html': ['tidy'],
\}

let g:ale_fixers = {
\   'python': ['autopep8'],
\   'javascript': ['eslint'],
\   'html': ['tidy'],
\}

let g:ale_sign_column_always = 1

" shortcut for ctags navigator plugin
nnoremap <NUL> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" sets column number and other misc stuff on bottom right
set ruler

" sets line at col 80
" set colorcolumn=80

let g:indentLine_enabled = 1

" maps leader key to spacebar
let mapleader="\<Space>"

" enabling the bottom function created by Bill Odom to have better searching
" capabilities
function! SearchWithSkip(pattern, flags, stopline, timeout, skip)
"
" Returns true if a match is found for {pattern}, but ignores matches
" where {skip} evaluates to false. This allows you to do nifty things
" like, say, only matching outside comments, only on odd-numbered lines,
" or whatever else you like.
"
" Mimics the built-in search() function, but adds a {skip} expression
" like that available in searchpair() and searchpairpos().
" (See the Vim help on search() for details of the other parameters.)
" 
    " Note the current position, so that if there are no unskipped
    " matches, the cursor can be restored to this location.
    "
    let l:matchpos = getpos('.')

    " Loop as long as {pattern} continues to be found.
    "
    while search(a:pattern, a:flags, a:stopline, a:timeout) > 0

        " If {skip} is true, ignore this match and continue searching.
        "
        if eval(a:skip)
            continue
        endif

        " If we get here, {pattern} was found and {skip} is false,
        " so this is a match we don't want to ignore. Update the
        " match position and stop searching.
        " 
        let l:matchpos = getpos('.')
        break

    endwhile

    " Jump to the position of the unskipped match, or to the original
    " position if there wasn't one.
    "
    call setpos('.', l:matchpos)

endfunction

function! SearchOutside(synName, pattern)
"
" Searches for the specified pattern, but skips matches that
" exist within the specified syntax region.
"
    call SearchWithSkip(a:pattern, '', '', '',
        \ 'synIDattr(synID(line("."), col("."), 0), "name") =~? "' . a:synName . '"' )

endfunction

function! SearchInside(synName, pattern)
"
" Searches for the specified pattern, but skips matches that don't
" exist within the specified syntax region.
"
    call SearchWithSkip(a:pattern, '', '', '',
        \ 'synIDattr(synID(line("."), col("."), 0), "name") !~? "' . a:synName . '"' )

endfunction

command! -nargs=+ -complete=command SearchOutside call SearchOutside(<f-args>)
command! -nargs=+ -complete=command SearchInside  call SearchInside(<f-args>)

" these will change C-n navigation mapping from C-p C-n to C-k C-j
" respectively
" inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
" inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

" map systemclipboard shortcuts to a better ones in normal and visual modes
nnoremap <Leader>y "+y
nnoremap <Leader>d "+d
vnoremap <Leader>y "+y
vnoremap <Leader>d "+d
" this maps it so that pasting from system clipboard will turn on paste mode
" for me
nnoremap <Leader>p :set paste<CR>"+p:set nopaste<CR>
nnoremap <Leader>P :set paste<CR>"+P:set nopaste<CR>
vnoremap <Leader>p :set paste<CR>"+p:set nopaste<CR>
vnoremap <Leader>P :set paste<CR>"+P:set nopaste<CR>

" vim hardcodes background color erase even if the terminfo file does
" not contain bce (not to mention that libvte based terminals
" incorrectly contain bce in their terminfo files). This causes
" incorrect background rendering when using a color theme with a
" background color.
let &t_ut=''

" Persistent undo
set undofile
" Puts all undo files in this directory
set undodir=~/HOME/undodir

" comment while keeping indentation
let g:NERDDefaultAlign = 'left'
