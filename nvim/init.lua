local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin', vim.fn.stdpath('data') .. '/plugged')

-- Treesitter!
Plug('nvim-treesitter/nvim-treesitter', {["do"] = ':TSUpdate'}) -- We recommend updating the parsers on update

-- Colorschemes
-- Plug 'haishanh/night-owl.vim' " My favorite but no treesitter support
Plug 'folke/tokyonight.nvim' -- Support treesitter!! All colorschemes below this support ts
-- Plug 'sainnhe/edge'
Plug 'shaunsingh/moonlight.nvim'

-- NVIM Tree
Plug 'nvim-tree/nvim-web-devicons' -- for file icons
Plug 'nvim-tree/nvim-tree.lua'

-- LSP
Plug 'williamboman/mason.nvim' -- This one is like ASDF for language servers for neovim
Plug 'williamboman/mason-lspconfig.nvim' -- This one bridges the above with lspconfig
Plug 'neovim/nvim-lspconfig'
Plug 'b0o/schemastore.nvim'

-- Improved UI, replacing vim defaults
Plug 'MunifTanjim/nui.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'folke/noice.nvim'

-- init.lua Lsp experience
Plug 'folke/neodev.nvim'

-- Git related
Plug 'mhinz/vim-signify'
Plug 'f-person/git-blame.nvim'

-- Status bar
Plug 'nvim-lualine/lualine.nvim'

-- Iconed Buffer bar (replace tab bar)
Plug 'romgrk/barbar.nvim'

-- Autocomplete (I don't know how these work)
Plug 'hrsh7th/nvim-cmp' -- Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip' -- Snippets plugin

-- Smooth scroll!!
Plug 'karb94/neoscroll.nvim'

-- Some old old old plugins, not sure if still needed
-- TODO review these
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'

-- Clojure
Plug('Olical/conjure', {tag = 'v4.43.0'})
Plug('eraserhd/parinfer-rust', {["do"] = "cargo build --release"})
-- Allow ANSI text in Conjure's log buffer
Plug('m00qek/baleia.nvim', { tag = 'v1.3.0' })

-- Depended by telescope, and spectre
Plug 'nvim-lua/plenary.nvim'
-- Very cool fuzzy finder for everything
Plug 'nvim-telescope/telescope.nvim'

-- Very cool motion tool!
Plug 'ggandor/leap.nvim'

-- Safe exrc
Plug 'klen/nvim-config-local'

-- Fancy project based search and replace
-- But I don't really use it for now..
-- Plug 'windwp/nvim-spectre'

vim.call('plug#end')

require('vim_self')
require('telescope_setup')
require('barbar_setup')
require('lsp_setup')
require('signify_setup')
require('clojure_related_setup')
require('nvim_tree_setup')

-- Tree sitter
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
require('neoscroll').setup() -- For fancy scrolling
require('leap').set_default_keymaps()
require('config-local').setup() -- klen/nvim-config-local
require('lualine').setup({
  -- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#show-recording-messages
  sections = {
    lualine_x = {
      {
        require("noice").api.statusline.mode.get,
        cond = function ()
          local mode = require("noice").api.statusline.mode.get()
          return not not (mode and string.find(mode, "recording"))
        end,
        color = { fg = "#ff9e64" },
      }
    },
  },
})
require('gitblame').setup({
  ignored_filetypes = { "NvimTree" },
  delay = 100
})
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

require('nvim_cmp_setup')
