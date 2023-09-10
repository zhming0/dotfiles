local u = require('util')

require('bufferline').setup{
  icons = {
    -- The default icon isn't supported by Hack Nerd Font
    pinned = { button = '' }
  }
}

u.nmap("<leader>[", ":BufferPrevious<CR>")
u.nmap("<leader>]", ":BufferNext<CR>")
u.nmap("<leader>x", ":BufferClose<CR>")
u.nmap("<leader>1", ":BufferGoto 1<CR>")
u.nmap("<leader>2", ":BufferGoto 2<CR>")
u.nmap("<leader>3", ":BufferGoto 3<CR>")
u.nmap("<leader>4", ":BufferGoto 4<CR>")
u.nmap("<leader>5", ":BufferGoto 5<CR>")
u.nmap("<leader>6", ":BufferGoto 6<CR>")
u.nmap("<leader>7", ":BufferGoto 7<CR>")
u.nmap("<leader>8", ":BufferGoto 8<CR>")
u.nmap("<leader>9", ":BufferLast<CR>")
