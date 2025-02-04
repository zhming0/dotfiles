local u = require('util')

return {
  'romgrk/barbar.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  init = function() vim.g.barbar_auto_setup = false end,
  version = '^1.0.0', -- optional: only update when a new 1.x version is released

  config = function()
    require('bufferline').setup({
      icons = {
        -- The default icon isn't supported by Hack Nerd Font
        pinned = { button = '' }
      }
    })
    u.nmap("<leader>[", ":BufferPrevious<CR>")
    u.nmap("<leader>]", ":BufferNext<CR>")
    u.nmap("<leader>x", ":BufferClose<CR>")
    u.nmap("<leader>X", ":BufferCloseAllButCurrentOrPinned<CR>")
    u.nmap("<leader>B", ":BufferPin<CR>")
    u.nmap("<leader>1", ":BufferGoto 1<CR>")
    u.nmap("<leader>2", ":BufferGoto 2<CR>")
    u.nmap("<leader>3", ":BufferGoto 3<CR>")
    u.nmap("<leader>4", ":BufferGoto 4<CR>")
    u.nmap("<leader>5", ":BufferGoto 5<CR>")
    u.nmap("<leader>6", ":BufferGoto 6<CR>")
    u.nmap("<leader>7", ":BufferGoto 7<CR>")
    u.nmap("<leader>8", ":BufferGoto 8<CR>")
    u.nmap("<leader>9", ":BufferLast<CR>")
  end
}
