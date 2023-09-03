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

" LSP
Plug 'williamboman/mason.nvim' " This one is like ASDF for language servers for neovim
Plug 'williamboman/mason-lspconfig.nvim' " This one bridges the above with lspconfig
Plug 'neovim/nvim-lspconfig'

" Improved UI, replacing vim defaults
Plug 'MunifTanjim/nui.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'folke/noice.nvim'

" Git related
Plug 'mhinz/vim-signify'
Plug 'f-person/git-blame.nvim'

" Status bar
Plug 'nvim-lualine/lualine.nvim'

" Iconed Buffer bar (replace tab bar)
Plug 'romgrk/barbar.nvim'

" Autocomplete
Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip' " Snippets plugin

" Smooth scroll!!
Plug 'karb94/neoscroll.nvim'

" Jsonnet
Plug 'google/vim-jsonnet'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'

" Clojure
Plug 'Olical/conjure', {'tag': 'v4.43.0'}
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}
" Allow ANSI text in Conjure's log buffer
Plug 'm00qek/baleia.nvim', { 'tag': 'v1.3.0' }

" Tmux Integration
" Commented it out because I don't feel this useful
" Plug 'christoomey/vim-tmux-navigator'

" Syntaxs
" Rust keeps getting new syntax the builtin syntax can't keep up
Plug 'rust-lang/rust.vim'
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

lua <<EOF
require('bufferline').setup{
  icons = {
    -- The default icon isn't supported by Hack Nerd Font
    pinned = { button = '' }
  }
}
EOF

"=====================================================
" Nvim LSP Config

lua <<EOF

require("mason").setup()
require("mason-lspconfig").setup{
  ensure_installed = { "elixirls", "tsserver" },
}

-- This is automatic lsp server setup for all servers in mason
require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,

  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  -- ["rust_analyzer"] = function ()
  --   require("rust-tools").setup {}
  -- end
}

-- language servers
local lspconfig = require('lspconfig')
-- LSP is managed by me manually.
lspconfig.clojure_lsp.setup {}
-- These two lines are not needed as mason have handled them. remove me later
-- lspconfig.tsserver.setup {}
-- lspconfig.elixirls.setup {}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts)
    -- Not sure what these are
    ---vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    ---vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    ---vim.keymap.set('n', '<space>wl', function()
    ---  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    ---end, opts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

EOF

" End Nvim LSP config
"===================================================

" Vim Signify (git diff indicator)
nnoremap <leader>hd :SignifyHunkDiff<cr>
nnoremap <leader>hu :SignifyHunkUndo<cr>

" Conjure
" disable auto-pair for clojure in favor of parinfer
autocmd BufNewFile,BufRead *.clj,*.cljc let g:AutoPairsShortcutToggle = ''
let g:conjure#log#hud#height = 1
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
  },
  view = {
    width = 40 -- Default 30
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

" Disable gitblame for nvimtree window
let g:gitblame_ignored_filetypes = [ 'NvimTree' ]
let g:gitblame_delay = 100

lua <<EOF
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})
EOF

lua <<EOF
-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
EOF
