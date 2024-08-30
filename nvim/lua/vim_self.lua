-- Contains configurations that are for Vim itself, or some global variable setups that aren't worth to be kept as a new file
local u = require('util')

local vim = vim

-- Enable line number
vim.opt.number = true
vim.opt.relativenumber = true

-- Use the line number columns to display signs
vim.opt.signcolumn = "number"

-- Coc recommend setting this shorter
-- I presume it will make CursorHold better which I think applies to Neovim lsp too
vim.opt.updatetime = 100

-- Enable mouse support
vim.opt.mouse = "a"

vim.opt.termguicolors = true

local cursorLineAuGroup = vim.api.nvim_create_augroup("CursorLine", {
  clear = true
})
vim.api.nvim_create_autocmd({"VimEnter", "WinEnter", "BufWinEnter"}, {
  group = cursorLineAuGroup,
  callback = function ()
    vim.opt_local.cursorline = true
  end
})
vim.api.nvim_create_autocmd({"WinLeave"}, {
  group = cursorLineAuGroup,
  callback = function ()
    vim.opt_local.cursorline = false
  end
})

-- For nagigatiion between windows
u.nmap("<C-h>", "<C-w>h")
u.nmap("<C-j>", "<C-w>j")
u.nmap("<C-k>", "<C-w>k")
u.nmap("<C-l>", "<C-w>l")

-- Quick save!
u.nmap("<leader><leader>", ":update<CR>")

-- Clipboard things
vim.opt.clipboard:append("unnamedplus")

vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function(_)
    local msg = string.format("Key:  %s", vim.fn.reg_recording())
    vim.notify(msg, vim.log.levels.INFO, {
      title = "Macro Recording"
    })
  end
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = function()
    local msg = string.format("Key:  %s", vim.fn.reg_recording())
    vim.notify(msg, vim.log.levels.INFO, {
      title = "Macro Recording Ended"
    })
  end
})

-- Copied from https://www.reddit.com/r/neovim/comments/vnodft/comment/ie87z9r/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
local wr_group = vim.api.nvim_create_augroup('WinResize', { clear = true })
vim.api.nvim_create_autocmd(
  'VimResized',
  {
    group = wr_group,
    pattern = '*',
    command = 'wincmd =',
    desc = 'Automatically resize windows when the host window size changes.'
  }
)

-- Exit terminal insert mode easily..
vim.api.nvim_set_keymap('t', '<leader><Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
