call plug#begin(stdpath('data') . '/plugged')

" Colorschemes
Plug 'haishanh/night-owl.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'folke/tokyonight.nvim'

" This requires fzf to be installed by Homebrew already
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" All CoC stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-tslint-plugin', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
  Plug 'iamcco/coc-diagnostic', {'do': 'yarn install --frozen-lockfile'}

" Git related
Plug 'mhinz/vim-signify'
Plug 'tveskag/nvim-blame-line'
Plug 'tpope/vim-fugitive'

" Status bar
Plug 'vim-airline/vim-airline'

" Typescript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'

" Clojure
Plug 'Olical/conjure', {'tag': 'v4.18.0'}
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}

" Tmux Integration
Plug 'christoomey/vim-tmux-navigator'

" Syntaxs
" Rust keeps getting new syntax the builtin syntax can't keep up
Plug 'rust-lang/rust.vim'
" TODO: consider maybe use lsp to replace it
Plug 'hashivim/vim-terraform'
Plug 'dag/vim-fish'

call plug#end()

" Enable line number
set number

" Coc recommand setting this shorter
" I presume it will make CursorHold better
set updatetime=300

" Enable project specific .vimrc
set exrc
set secure

" Enable true color
if exists('+termguicolors')
  " I don't know if this line helps
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  " I don't know if this line helps
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" FZF VIM integration
" CtrlP similar key
nnoremap <silent> <c-p> :FZF<CR>
" search entire codebase
nnoremap <silent> <Leader>f :Rg<CR>
" search current file
nnoremap <silent> <Leader>/ :BLines<CR>

" Choose my favorate color scheme
colorscheme night-owl

" For nagigatiion between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Make ctrl-c behave exactly the same with Esc
" Helpful in visualmode
vnoremap <C-c> <Esc>
inoremap <C-c> <Esc>

" Prefer space as tab -> use 2 spaces as tab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" filetype hack to allow tsserver to parse tsx and jsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

" Enable auto remove trailing white spaces
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Quick save \ + s
noremap <Leader><Leader> :update<CR>

"=====================================================
" VIM CoC (lang client)

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" use cr to select the completion item
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Allow C-f and C-b to work on pop up if there is one on the screen
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" use :Fold to fold a region
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Some extra plugins
" coc-conjure can make omnicomplete provided by conjure work with CoC
let g:coc_global_extensions = ['coc-conjure']


" End VIM CoC
"===================================================

" Vim Signify (git diff indicator)
nnoremap <leader>hd :SignifyHunkDiff<cr>
nnoremap <leader>hu :SignifyHunkUndo<cr>

" This allow external process's change to fg/bg color to have a visible
" differerence on VIM
highlight Normal guifg=#e6e1de ctermfg=none gui=none
" highlight LineNr guifg=yellow ctermfg=none gui=none

" :Rg with preview window
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" ===========================================
" Customization for vim-jsx-typescript
" dark red
hi tsxTagName guifg=#E06C75

" orange
hi tsxCloseString guifg=#F99575
hi tsxCloseTag guifg=#F99575
hi tsxCloseTagName guifg=#F99575
hi tsxAttributeBraces guifg=#F99575
hi tsxEqual guifg=#F99575

" yellow
hi tsxAttrib guifg=#F8BD7F cterm=italic
"============================================

" Conjure
" disable auto-pair for clojure in favor of parinfer
autocmd BufNewFile,BufRead *.clj,*.cljc let g:AutoPairsShortcutToggle = ''
let g:conjure#log#hud#height = 0.66
let g:conjure#log#wrap = 'true'

" Netrw
" Make it view directory as a tree
let g:netrw_liststyle = 3
let g:netrw_preview = 1

" Clipboard stuff
" use register + as buffer for clipboard
set clipboard+=unnamedplus
" Use <leader> + regular yank/put keys to copy/paste from clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
