local vim = vim
return {
  'stevearc/conform.nvim',
  version = "*",
  event = { "BufWritePre" }, -- Lazy load
  opts = {
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 5000, lsp_format = "fallback" }
    end,
    default_format_opts = {
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      prisma = { "prisma_fmt" }
    },
    formatters = {
      prisma_fmt = {
        command = "pnpx",
        args = {
          "prisma",
          "format",
          "--schema",
          "$FILENAME"
        },
        stdin = false -- Prisma formatter doesn't accept stdin
      }
    },
  },

  init = function()
    -- It's unclear if this is actually useful..
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })
  end,
}
