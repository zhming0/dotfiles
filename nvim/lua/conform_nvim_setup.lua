return {
  'stevearc/conform.nvim',
  version = "*",
  event = { "BufWritePre" }, -- Lazy load
  opts = {
    -- Since I mostly rely on format on save, adding a format requires some prudence.
    format_on_save = {
      -- Consider a timeout setting? timeout = 3000?
      lsp_format = "fallback",
    },
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
  end,
}
