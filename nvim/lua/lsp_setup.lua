local vim = vim

require("mason").setup()
require("mason-lspconfig").setup{
  -- To find available names: https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/server_configurations
  ensure_installed = {
    "ts_ls",
    "pyright",
    -- These 4 are all managed by https://github.com/hrsh7th/vscode-langservers-extracted
    "cssls" , "jsonls", "html", "eslint",
    "yamlls", "bashls",
    "lua_ls", -- Only need this for `init.lua` for now..
    "jdtls",
    "gopls",
    "golangci_lint_ls",
    "dockerls",
    "ruby_lsp",
    "harper_ls",
    "terraformls",
    "tflint",
  },
}

local base_capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_capabilities = require("cmp_nvim_lsp").default_capabilities()
local capabilities = vim.tbl_deep_extend(
  "force",
  base_capabilities,
  cmp_nvim_capabilities
)

-- Used by `nvim-ufo`
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

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

-- I learned it from https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316#controlling-when-highlights-are-applied
local function disable_lsp_semantic_highlight(buf)
  vim.api.nvim_create_autocmd({"LspTokenUpdate"}, {
    buffer = buf,
    callback = function(_)
      for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
      end
    end
  })
end

local function disable_lsp_for_conjure_log_buffer()
  vim.api.nvim_create_autocmd("BufNewFile", {
    group = vim.api.nvim_create_augroup("conjure_log_disable_lsp", { clear = true }),
    pattern = { "conjure-log-*" },
    callback = function() vim.diagnostic.disable(0) end,
    desc = "Conjure Log disable LSP diagnostics",
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
  end,

  ["gopls"] = function ()
    require('lspconfig').gopls.setup {
      capabilities = capabilities,
      settings = {
        gopls = {
          buildFlags = {"-tags=test"}
        },
      },
    }
  end,

  ["jdtls"] = function ()
    -- Skip because we use nvim-jdtls to manage jdtls
    -- But we still use mason to install the jdt.ls for easiness
  end,

  ["harper_ls"] = function ()
    require('lspconfig').harper_ls.setup {
      settings = {
        ["harper-ls"] = {
          linters = {
            spell_check = false,
            spelled_numbers = false,
            an_a = true,
            sentence_capitalization = false,
            unclosed_quotes = true,
            wrong_quotes = false,
            long_sentences = true,
            repeated_words = true,
            spaces = true,
            matcher = true,
            correct_number_suffix = true,
            number_suffix_capitalization = true,
            multiple_sequential_pronouns = true,
          }
        }
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
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client.server_capabilities.documentHighlightProvider then
      handle_document_highlight(ev.buf)
    end

    if client.name == "clojure_lsp" then
      disable_lsp_semantic_highlight(ev.buf)
    end

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    --  I could use the original quickfix based solution but telescope looks better :)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gr', function ()
      require("telescope.builtin").lsp_references({
        layout_strategy = "vertical",
        layout_config = { preview_height = 0.8 },
        include_current_line = true, -- somehow this means exclude, which is what I want
      })
    end, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts)

    -- Not sure what these are
    ---vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    ---vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    ---vim.keymap.set('n', '<space>wl', function()
    ---  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    ---end, opts)

    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>=', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

disable_lsp_for_conjure_log_buffer()

vim.diagnostic.config({
  -- Only show virtual text if the severity is error
  virtual_text = {
    severity = vim.diagnostic.severity.ERROR,
    severity_sort = true,
  }
})
