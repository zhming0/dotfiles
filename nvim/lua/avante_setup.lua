return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = "*",
  build = "make",
  opts = {
    provider = "claude",
    claude = {
      model = "claude-3-7-sonnet-latest"
    },
    auto_suggestions_provider = "groq",
    behaviour = {
      -- It's important to note that this will effectively upload to cloud.
      -- We need to keep updated to see if there is a way to disable this automatically in certain cases.
      -- It's disabled as I find it quickily hit limit. somehow...
      auto_suggestions = false, -- Experimental stage
    },

    vendors = {
      groq = {
        __inherited_from = "openai",
        api_key_name = "GROQ_API_KEY",
        endpoint = "https://api.groq.com/openai/v1/",
        model = "llama-3.3-70b-versatile",
      },
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
