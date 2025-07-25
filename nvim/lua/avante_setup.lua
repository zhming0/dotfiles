return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = "*",
  build = "make",
  opts = {
    provider = "claude",
    providers = {
      claude = {
        model = "claude-sonnet-4-20250514",
        disable_tools = true,
        extra_request_body = {
          temperature = 0,
        }
      }
    },
    behaviour = {
      enable_cursor_planning_mode = true
    },

    windows = {
      width = 40 -- default 30%
    },
  },
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
