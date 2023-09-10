local u = require('util')

return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {"nvim-lua/plenary.nvim"},
  config = function ()
    require('telescope').setup{
      defaults = {
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
        }
      },
    }

    u.nmap("<c-p>", "<cmd>Telescope find_files hidden=true follow=true<cr>")
    u.nmap("<leader>f", "<cmd>Telescope live_grep<cr>")
    u.nmap("<leader>b", "<cmd>Telescope buffers<cr>")
    u.nmap("<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
  end
}
