call plug#begin(stdpath('data') . '/plugged')
" Treesitter!
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" Colorschemes
" Plug 'haishanh/night-owl.vim' " My favorite but no treesitter support
Plug 'folke/tokyonight.nvim' " Support treesitter!! All colorschemes below this support ts
"Plug 'sainnhe/edge'
Plug 'shaunsingh/moonlight.nvim'

" NVIM Tree
Plug 'nvim-tree/nvim-web-devicons' " for file icons
Plug 'nvim-tree/nvim-tree.lua'

" All CoC stuff
" Note coc.nvim isn't the most stable software, so I try to ping to commit.
Plug 'neoclide/coc.nvim', {'branch': 'release', 'commit': '95b43f67147391cf2c69e550bd001b742781d226'}
  Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-tslint-plugin', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
  Plug 'iamcco/coc-diagnostic', {'do': 'yarn install --frozen-lockfile'} " Turn diagnostic tool into LSP plugins
  Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-solargraph', {'do': 'yarn install --frozen-lockfile'}

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

" Jsonnet
Plug 'google/vim-jsonnet'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'

" Clojure
Plug 'Olical/conjure', {'tag': 'v4.42.0'}
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}
" Allow ANSI text in Conjure's log buffer
Plug 'm00qek/baleia.nvim', { 'tag': 'v1.2.0' }

" Tmux Integration
Plug 'christoomey/vim-tmux-navigator'

" Syntaxs
" Rust keeps getting new syntax the builtin syntax can't keep up
Plug 'rust-lang/rust.vim'
" TODO: consider maybe use lsp to replace it
Plug 'hashivim/vim-terraform'
Plug 'dag/vim-fish'

" Depended by telescope, and spectre
Plug 'nvim-lua/plenary.nvim'
" Very cool fuzzy finder for everything
Plug 'nvim-telescope/telescope.nvim'

" Very cool motion tool!
Plug 'ggandor/leap.nvim'

" Safe exrc
Plug 'klen/nvim-config-local'

" Fancy project based search and replace
Plug 'windwp/nvim-spectre'

call plug#end()

" Enable line number
set number

" Use the line number columns to display signs
set signcolumn=number

" Coc recommend setting this shorter
" I presume it will make CursorHold better
set updatetime=300

" Enable project specific .vimrc
" set exrc
" set secure

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

" Use different | so Indentation Guild looks better :)
" let g:indent_blankline_char = "│"
let g:indent_blankline_char = " "
let g:indent_blankline_char_highlight_list = ['Ignore', 'StatusLine']
let g:indent_blankline_space_char_highlight_list = ['Ignore', 'StatusLine']
let g:indent_blankline_enabled = v:false " nice plugin but don't need it now :(


" FZF VIM integration
" CtrlP similar key (this is using fd underneath)
nnoremap <c-p> <cmd>Telescope find_files hidden=true follow=true<cr>
nnoremap <leader>f <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>/ <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>t <cmd>Telescope treesitter<cr>

" Choose my favorate color scheme
let g:tokyonight_italic_functions = 1
let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]
"let g:edge_style = "neon"
let g:airline_theme = "deus"
let g:airline_powerline_fonts = 1
colorscheme tokyonight-moon

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
" Barbar

nnoremap <silent>    <leader>[ :BufferPrevious<CR>
nnoremap <silent>    <leader>] :BufferNext<CR>
nnoremap <silent>    <leader>x :BufferClose<CR>
nnoremap <silent>    <leader>1 :BufferGoto 1<CR>
nnoremap <silent>    <leader>2 :BufferGoto 2<CR>
nnoremap <silent>    <leader>3 :BufferGoto 3<CR>
nnoremap <silent>    <leader>4 :BufferGoto 4<CR>
nnoremap <silent>    <leader>5 :BufferGoto 5<CR>
nnoremap <silent>    <leader>6 :BufferGoto 6<CR>
nnoremap <silent>    <leader>7 :BufferGoto 7<CR>
nnoremap <silent>    <leader>8 :BufferGoto 8<CR>
nnoremap <silent>    <leader>9 :BufferLast<CR>

let bufferline = get(g:, 'bufferline', {})
let bufferline.icon_pinned = '' " The default icon isn't supported by Hack Nerd Font

"=====================================================
" VIM CoC (lang client)

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
\ coc#pum#visible() ? coc#pum#next(1):
\ <SID>check_back_space() ? "\<Tab>" :
\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" use cr to select the completion item
inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac <Plug>(coc-codeaction)

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

" use :Prettier to invoke prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Replace vim's default spellcheck with coc-typos
" Move to next misspelled word after the cursor, 'wrapscan' applies.
nmap ]s <Plug>(coc-typos-next)
" Move to previous misspelled word after the cursor, 'wrapscan' applies.
nmap [s <Plug>(coc-typos-prev)
" Fix typo at cursor position
nmap z= <Plug>(coc-typos-fix)

" Some extra plugins - these are managed by coc entirely
" coc-conjure can make omnicomplete provided by conjure work with CoC
" Clangd is LSP for C Lang
let g:coc_global_extensions = ['coc-conjure', 'coc-clangd', 'coc-java', 'coc-rls', 'coc-typos']


" End VIM CoC
"===================================================

" Vim Signify (git diff indicator)
nnoremap <leader>hd :SignifyHunkDiff<cr>
nnoremap <leader>hu :SignifyHunkUndo<cr>

" Conjure
" disable auto-pair for clojure in favor of parinfer
autocmd BufNewFile,BufRead *.clj,*.cljc let g:AutoPairsShortcutToggle = ''
let g:conjure#log#hud#height = 0.66
let g:conjure#log#wrap = 'true'
" Disable Conjure's K shortcut in favor of LSP's support
let g:conjure#mapping#doc_word = v:false

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

" ============================================
" Treesitter configuration
" check https://github.com/nvim-treesitter/nvim-treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = { "norg", "phpdoc" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "nim", "jsonnet", "markdown" },  -- list of language that will be disabled
  },
  indent = {
    enable = true
  },
  view = {
    width = 40 -- Default 30
  },
  renderer = {
    show = {
      -- Disable git logo because it's slow in very big repo
      -- https://github.com/kyazdani42/nvim-tree.lua/issues/172
      -- https://github.com/kyazdani42/nvim-tree.lua/issues/549
      file = true,
      folder = true,
      folder_arrows = true,
      git = false
    }
  }
}
EOF

" Neoscroll setup
lua require('neoscroll').setup()
" Nvim Tree setup
lua <<EOF
require'nvim-tree'.setup {
  actions = {
    open_file = {
      quit_on_open = true,
    }
  }
}
EOF

" In the very end, try to load a local.vim configuration if this file exist
" besides the init.vim
let _local_config_path=stdpath('config')."/local.vim"
if filereadable(_local_config_path)
  exec 'source ' . _local_config_path
endif

" To check default config
" :help telescope.setup()
lua <<EOF
require('telescope').setup{
  defaults = {
    -- Otherwise by default it would ignore all dotfiles
    vimgrep_arguments = {
      "rg",
      "--hidden",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case"
    }
  },
}
EOF

" Leap Setup
lua require('leap').set_default_keymaps()

" For klen/nvim-config-local
lua require('config-local').setup()

" Allow seeing color in conjure log buffer
let s:baleia = luaeval("require('baleia').setup { line_starts_at = 3 }")
autocmd BufWinEnter conjure-log-* call s:baleia.automatically(bufnr('%'))
