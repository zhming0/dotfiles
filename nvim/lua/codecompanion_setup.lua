local vim = vim

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim", -- Optional
    {
      "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
      opts = {
        input = {
          enabled = false -- noice handles this.
        }
      },
    },
  },
  event = "VeryLazy",
  config = function ()

    require("codecompanion").setup({
      adapters = {
        openai = require("codecompanion.adapters").use("openai", {
          env = {
            api_key = "OPENAI_API_KEY",
          },
        }),
        strategies = {
          chat = "openai",
          inline = "openai"
        },
      },
    })

    vim.api.nvim_set_keymap("n", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<LocalLeader>a", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<LocalLeader>a", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })
    vim.cmd([[cab cc CodeCompanion]])
  end
}
