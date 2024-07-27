local vim = vim

local send_txt = function(context)
  local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

  return "I have the following text/code:\n\n```" .. context.filetype .. "\n" .. text .. "\n```\n\n"
end

local generate_action_item = function(name, prompt)
  return {
    name = name,
    strategy = "inline",
    description = name,
    opts = {
      modes = { "v" },
    },
    prompts = {
      {
        role = "system",
        content = "You are an expert writer/coder and helpful assistant who can help writing and coding. Your writing style is concise and impactful, without any unnecessary fluff.",
      },
      {
        role = "user",
        contains_code = true,
        content = function(context)
          return send_txt(context)
        end,
      },
      {
        role = "user",
        content = prompt .. " Only return the improved writing or code without any wraps.",
      },
    },
  }
end

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
        })
      },

      strategies = {
        chat = {
          adapter = "openai",
        },
        inline = {
          adapter = "openai",
        },
      },

      -- This doesn't work yet.
      prompts = {
        ["Whaaaat"] = {
        }
      },

      actions = {
        {
          name = "Ming Writing",
          strategy = "inline",
          description = "Help writing and coding in general, Ming's custom actions.",
          picker = {
            items = {
              generate_action_item("Improve writing", "Please improve writing for me while respecting the existing format and meaning."),
              generate_action_item("Grammar", "Please fix grammar and spelling for me."),
            },
          },
        },
      }
    })

    vim.api.nvim_set_keymap("n", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<LocalLeader>a", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<LocalLeader>a", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })
    vim.cmd([[cab cc CodeCompanion]])
  end
}
