local vim = vim

-- make lua ls work with init.lua
require("neodev").setup({})

require("mason").setup()
require("mason-lspconfig").setup{
  -- To find available names: https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/server_configurations
  ensure_installed = {
    "tsserver", "pyright",
    -- These 4 are all managed by https://github.com/hrsh7th/vscode-langservers-extracted
    "cssls" , "jsonls", "html", "eslint",
    "yamlls", "bashls",
    "lua_ls", -- Only need this for init.lua for now..
  },
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function handle_document_highlight(buffer)
  vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
    buffer = buffer,
    callback = function(_)
      vim.lsp.buf.document_highlight()
    end
  })
  vim.api.nvim_create_autocmd({"CursorMoved"}, {
    buffer = buffer,
    callback = function(_)
      vim.lsp.buf.clear_references()
    end
  })
end

-- This is automatic lsp server setup for all servers in mason
require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      capabilities = capabilities,
    }
  end,

  -- Next, you can provide a dedicated handler for specific servers.
  ["jsonls"] = function ()
    require('lspconfig').jsonls.setup {
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    }
  end
}

-- language servers
local lspconfig = require('lspconfig')
-- LSP is managed by me manually.
lspconfig.clojure_lsp.setup {
  capabilities = capabilities,
}

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

    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client.server_capabilities.documentHighlightProvider then
      handle_document_highlight(ev.buf)
    end

    -- Disable semantic highlight for Clojure LSP
    -- I learnt it from https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316#controlling-when-highlights-are-applied
    if client.name == "clojure_lsp" then
      vim.api.nvim_create_autocmd({"LspTokenUpdate"}, {
        buffer = ev.buf,
        callback = function(_)
          for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
            vim.api.nvim_set_hl(0, group, {})
          end
        end
      })
    end

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
    vim.keymap.set('n', '<leader>=', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
