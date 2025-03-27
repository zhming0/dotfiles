return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = "*",
  build = "make",
  opts = {
    provider = "claude",
    cursor_applying_provider = 'groq',
    claude = {
      model = "claude-3-7-sonnet-latest"
    },
    behaviour = {
      enable_cursor_planning_mode = true
    },

    vendors = {
      groq = {
        __inherited_from = "openai",
        api_key_name = "GROQ_API_KEY",
        endpoint = "https://api.groq.com/openai/v1/",
        model = "llama-3.3-70b-versatile",
        max_tokens = 32768, -- People say: remember to increase this value, otherwise it will stop generating halfway
      },
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
