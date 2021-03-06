call plug#begin(stdpath('data') . '/plugged')

" Treesitter!
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" Colorschemes
" Plug 'haishanh/night-owl.vim' " My favorite but no treesitter support
Plug 'folke/tokyonight.nvim' " Support treesitter!! All colorschemes below this support ts
"Plug 'sainnhe/edge'
Plug 'shaunsingh/moonlight.nvim'

" This requires fzf to be installed by Homebrew already
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" NVIM Tree
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" All CoC stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-tslint-plugin', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
  Plug 'iamcco/coc-diagnostic', {'do': 'yarn install --frozen-lockfile'}

" Git related
Plug 'mhinz/vim-signify'
Plug 'tveskag/nvim-blame-line'
Plug 'tpope/vim-fugitive'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Iconed Buffer bar (replace tab bar)
Plug 'romgrk/barbar.nvim'

" Indentation Guide
" Plug 'lukas-reineke/indent-blankline.nvim'

" Smooth scroll!!
Plug 'karb94/neoscroll.nvim'

" Typescript
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'

" Clojure
Plug 'Olical/conjure', {'tag': 'v4.19.0'}
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

" Enable mouse support
set mouse=a

" Enable true color
if exists('+termguicolors')
  set termguicolors
endif

" Highlight current line in the active window
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Use different | so Identation Guild looks better :)
" let g:indent_blankline_char = "│"
let g:indent_blankline_char = " "
let g:indent_blankline_char_highlight_list = ['Ignore', 'StatusLine']
let g:indent_blankline_space_char_highlight_list = ['Ignore', 'StatusLine']
let g:indent_blankline_enabled = v:false " nice plugin but don't need it now :(


" FZF VIM integration
" CtrlP similar key
nnoremap <silent> <c-p> :Files<CR>
" search buffers by file name
nnoremap <Leader>b :Buffers<CR>
" search entire codebase by content
nnoremap <silent> <Leader>f :Rg<CR>
" search current file
nnoremap <silent> <Leader>/ :BLines<CR>

" Choose my favorate color scheme
let g:tokyonight_style = "night"
let g:tokyonight_italic_functions = 1
let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]
"let g:edge_style = "neon"
let g:airline_theme = "deus"
let g:airline_powerline_fonts = 1
colorscheme tokyonight

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

" Use Tab for golang
autocmd BufNewFile,BufRead *.go setlocal noet ts=2 sw=2 sts=2 noexpandtab
" Remove useless import upon save
autocmd BufWritePre *.go silent! call CocAction('runCommand', 'editor.action.organizeImport')

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

" :Rg with preview window
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)


" Conjure
" disable auto-pair for clojure in favor of parinfer
autocmd BufNewFile,BufRead *.clj,*.cljc let g:AutoPairsShortcutToggle = ''
let g:conjure#log#hud#height = 0.66
let g:conjure#log#wrap = 'true'

" At the time of writing it, the colorscheme that I am using does not set
" color for NormalFloat group
highlight NormalFloat ctermbg=black guibg=black

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

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
let g:nvim_tree_quit_on_open = 1 " Close the tree when open a file

" ============================================
" Treesitter configuration
" check https://github.com/nvim-treesitter/nvim-treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {  }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
  },
}
EOF

" Neoscroll setup
lua require('neoscroll').setup()
