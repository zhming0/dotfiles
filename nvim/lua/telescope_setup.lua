local u = require('util')

return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {"nvim-lua/plenary.nvim"},
  event = "VeryLazy",
  config = function ()
    require('telescope').setup{
      defaults = {
        path_display = {"smart"},
        layout_strategy = "flex",
        -- Otherwise by default it would ignore all dotfiles
        vimgrep_arguments = {
          "rg",
          "--hidden",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case"
        },
      },
    }

    u.nmap("<c-p>", "<cmd>Telescope find_files hidden=true follow=true<cr>")
    u.nmap("<leader>f", "<cmd>Telescope live_grep<cr>")
    u.nmap("<leader>F", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>")
    u.nmap("<leader>b", "<cmd>Telescope buffers<cr>")
    u.nmap("<leader>/", "<cmd>Telescope treesitter<cr>")
  end
}
