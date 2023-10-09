local vim = vim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Color schemes
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup as it is my main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.g.tokyonight_italic_functions = 1
      vim.cmd.colorscheme("tokyonight-moon")
    end,
  },
  "shaunsingh/moonlight.nvim",

  -- Treesitter!
  require('treesitter_setup'),

  -- NVIM Tree
  require('nvim_tree_setup'),

  -- LSP
  'williamboman/mason.nvim', -- This one is like ASDF for language servers for neovim
  'williamboman/mason-lspconfig.nvim', -- This one bridges the above with lspconfig
  'neovim/nvim-lspconfig',
  'b0o/schemastore.nvim',
  require('nvim_jdtls_setup'),

  -- Improved UI, replacing vim defaults
  'MunifTanjim/nui.nvim',
  'rcarriga/nvim-notify',
  {'folke/noice.nvim', version ="*"},
  'kevinhwang91/nvim-bqf', -- Better looking quickfix list

  -- init.lua Lsp experience
  'folke/neodev.nvim',

  -- Git related
  'mhinz/vim-signify',
  'f-person/git-blame.nvim',

  -- Status bar
  'nvim-lualine/lualine.nvim',

  -- Iconed Buffer bar (replace tab bar)
  require('barbar_setup'),

  -- Autocomplete (I don't know how these work)
  'hrsh7th/nvim-cmp', -- Autocompletion plugin
  'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
  'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
  'L3MON4D3/LuaSnip', -- Snippets plugin
  {'ray-x/cmp-treesitter', event = "VeryLazy"}, -- Sources for nvim-cmp
  {'hrsh7th/cmp-emoji', event = "VeryLazy"}, -- Sources for nvim-cmp

  -- Smooth scroll!!
  {'karb94/neoscroll.nvim', config=true},

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true
  },
  -- Some old old old plugins, not sure if still needed
  -- TODO review these
  'tpope/vim-repeat',
  'jiangmiao/auto-pairs',

  -- Clojure
  {
    "Olical/conjure",
    ft = {"clojure"},
    version = "*"
  },
  {
    "eraserhd/parinfer-rust",
    build = "cargo build --release"
  },
  {
    "m00qek/baleia.nvim",
    tag = "v1.3.0",
    event = "BufEnter conjure-log-*",
    config = function ()
      local baleia = require('baleia').setup()
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = {"conjure-log-*"},
        callback = function (ev)
          baleia.automatically(ev.buf)
        end
      })
    end
  },

  -- Very cool fuzzy finder for everything
  require('telescope_setup'),

  'ggandor/leap.nvim',
  {'klen/nvim-config-local', config=true}
}, {
  defaults = {
    lazy = false
  }
})

require('vim_self')
require('lsp_setup')
require('signify_setup')
require('clojure_related_setup')

require('leap').set_default_keymaps()
-- require('config-local').setup() -- klen/nvim-config-local
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
require('bqf').setup()
