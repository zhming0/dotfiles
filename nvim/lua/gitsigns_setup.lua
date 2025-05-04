local u = require('util')

u.nmap("<leader>hd", ":Gitsigns preview_hunk_inline<cr>")
u.nmap("<leader>hu", ":Gitsigns reset_hunk<cr>")
u.nmap("]c", ":Gitsigns nav_hunk next<cr>")
u.nmap("[c", ":Gitsigns nav_hunk prev<cr>")
