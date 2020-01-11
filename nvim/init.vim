call plug#begin(stdpath('data') . '/plugged')

Plug 'junegunn/seoul256.vim'

" This requires fzf to be installed by Homebrew already
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()

" Enable line number
set number

" FZF VIM integration
" CtrlP similar key
nnoremap <silent> <c-p> :FZF<CR>

" Choose my favorate color scheme
colorscheme seoul256
