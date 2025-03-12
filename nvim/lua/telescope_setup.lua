local u = require('util')

return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  config = function()
    require('telescope').setup {
      defaults = {
        -- This seems nice on the surface, but doesn't seem to improve my experience.
        -- path_display = { "smart" },
        layout_strategy = "flex",
        layout_config = {
          flex = {
            -- Try to use vertical view for narrow screen
            flip_columns = 180
          }
        },
        cache_picker = {
          num_pickers = 10,
        },
        -- Otherwise by default it would ignore all dotfiles
        vimgrep_arguments = {
          "rg",
          "--hidden",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim", -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#ripgrep-remove-indentation
        },
      },
    }

    -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
    -- It still has a problem, untracked file can't be found in git repo.
    u.nmap("<c-p>", "<cmd>lua require'telescope_config'.project_files()<cr>")
    -- https://github.com/nvim-telescope/telescope.nvim/pull/1051
    u.nmap("<leader>p", "<cmd>lua require('telescope.builtin').pickers()<cr>")
    u.nmap("<leader>f", "<cmd>Telescope live_grep<cr>")
    u.nmap("<leader>F", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>")
    u.nmap("<leader>b", "<cmd>Telescope buffers<cr>")
    u.nmap("<leader>/", "<cmd>Telescope treesitter<cr>")
  end
}
