set nocompatible              " be iMproved, required
filetype off                  " required

" For fish-shell
if $SHELL =~ 'bin/fish'
    set shell=/bin/sh
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle
" required! 
Plugin 'gmarik/Vundle.vim'

" My Plugins
Plugin 'bling/vim-airline'
set laststatus=2

Plugin 'vim-scripts/VimClojure'
Plugin 'derekwyatt/vim-scala'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'ksauzz/thrift.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'othree/html5.vim'
Plugin 'elzr/vim-json'
Plugin 'vim-scripts/Cpp11-Syntax-Support'
Plugin 'tikhomirov/vim-glsl'
Plugin 'digitaltoad/vim-jade'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'dag/vim-fish'
Plugin 'tpope/vim-fireplace'

" Colorscheme
Plugin 'pyte'
Plugin 'flazz/vim-colorschemes'
Plugin 'jpo/vim-railscasts-theme'
Plugin 'jonathanfilip/vim-lucius'
Plugin 'zeis/vim-kolor'
Plugin 'junegunn/seoul256.vim'

call vundle#end()
filetype plugin indent on 

" ==================================
"  Actual vim configuration goes here
syntax on
set autoindent
set cindent
set number

" Prevent beep
set vb t_vb=
 
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype css setlocal ts=2 sts=2 sw=2
autocmd Filetype scss setlocal ts=2 sts=2 sw=2
"autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 sts=4
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 sts=2
autocmd FileType scala setlocal sw=2 ts=2 sts=2
autocmd FileType jade setlocal sw=2 ts=2 sts=2
autocmd FileType python setlocal sw=2 ts=2 sts=2
autocmd FileType make setlocal noexpandtab sw=8 ts=8 sts=8

" Quick save
let mapleader = ","
noremap <Leader>s :update<CR>

set t_Co=256
" These are my favor colorschemes
"colorscheme kolor
"colorscheme Tomorrow-Night
colorscheme seoul256
"colorscheme pyte

" For CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" For nagigatiion between windows 
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Backspace behaviour in vim 7.4
set backspace=indent,eol,start 

" SuperTab
let g:SuperTabDefaultCompletionType = "<c-n>"

" Highlight for *.md files
au BufRead,BufNewFile *.md set filetype=markdown

" Neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.out 
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.git|\.hg|\.svn|node_modules|dist|bower_components)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
    \ }

" vim-jsx
let g:jsx_ext_required = 0

" vim-fireplace
autocmd User FireplacePreConnect call fireplace#register_port_file(expand('~/.lein/repl-port'), '/')
