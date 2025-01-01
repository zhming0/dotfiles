local vim = vim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
    version = "*",
    lazy = false, -- make sure we load this during startup as it is my main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.g.tokyonight_italic_functions = 1
      vim.cmd.colorscheme("tokyonight-moon")
    end,
  },
  "shaunsingh/moonlight.nvim",

  -- Automatic session management, this is eager loaded.
  require('persisted_setup'),

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
  'rcarriga/nvim-notify',
  {
    'folke/noice.nvim',
    -- version = "*",
    -- https://github.com/Saghen/blink.cmp/issues/618
    -- revert this when https://github.com/folke/noice.nvim/pull/1015 is merged.
    commit = "eaed6cc9c06aa2013b5255349e4f26a6b17ab70f",
  },
  'kevinhwang91/nvim-bqf', -- Better looking quickfix list

  -- init.lua Lsp experience
  { 'folke/neodev.nvim', ft = "lua", config = true },

  -- Git related
  -- TODO: consider replacing with https://github.com/lewis6991/gitsigns.nvim because_it has wider adoption
  'mhinz/vim-signify',
  'f-person/git-blame.nvim',

  -- Status bar
  'nvim-lualine/lualine.nvim',

  -- Iconed Buffer bar (replace tab bar)
  require('barbar_setup'),

  require('blink_cmp_setup'),

  -- Smooth scroll and everything!!
  {
    'echasnovski/mini.nvim',
    version = '*',
    config=function ()
      require('mini.animate').setup()
    end
  },

  -- Fancy modern scroll bar
  {'petertriho/nvim-scrollbar', config=true, event="VeryLazy"},

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
    version = "*",
  },
  'gpanders/nvim-parinfer',
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

  -- Golang
  {
    "ray-x/go.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
      require('golang_related_setup')
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    -- build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },

  -- Very cool fuzzy finder for everything
  require('telescope_setup'),

  'ggandor/leap.nvim',
  {'klen/nvim-config-local', config=true, lazy=false},

  -- Fancy indentation tool
  require('nvim_ufo_setup'),

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = true,
    version = "*",
  },

  require('avante_setup'),

  -- This is really handly tool, use <leader>R allows me to send any command to a tmux panel (once selected).
  {
    'samharju/yeet.nvim',
    dependencies = {
      "stevearc/dressing.nvim" -- optional, provides sane UX
    },
    cmd = 'Yeet',
    opts = {},
    keys = {
      {
        "<leader>R", function() require("yeet").execute() end,
      },
    }
  },

  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },

  {
    "ruifm/gitlinker.nvim",
    config = true,
    event = "VeryLazy",
  },
  -- This seems useful but I have no use case just yet, enable me when timing is right!
  -- {'TreyBastian/nvim-jack-in', config = true},
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
      },
      'searchcount',
      'selectioncount',
      {
        'filetype',
        icon_only = true, -- Display only an icon for filetype
      },
    },
    lualine_c = {
      {
        'filename',
        path = 1 -- Show relative path
      },
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

require('bqf').setup()
