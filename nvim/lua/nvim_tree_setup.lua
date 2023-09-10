local u = require('util')

require'nvim-tree'.setup {
  actions = {
    open_file = {
      quit_on_open = true,
    }
  },
  view = {
    width = 40 -- Default 30
  }
}

u.nmap("<C-n>", ":NvimTreeToggle<CR>")
u.nmap("<leader>n", ":NvimTreeFindFile<CR>")
