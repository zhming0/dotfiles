-- Contains configurations that are for Vim itself, or some global variable setups that aren't worth to be kept as a new file
local u = require('util')

local vim = vim

-- Enable line number
vim.opt.number = true
vim.opt.relativenumber = false

-- Coc recommend setting this shorter
-- I presume it will make CursorHold better which I think applies to Neovim lsp too
vim.opt.updatetime = 100

-- Enable mouse support
vim.opt.mouse = "a"

vim.opt.termguicolors = true

-- By default ignore case when using native search
vim.opt.ignorecase = true
-- If at least one upper case is used, don't ignore case
vim.opt.smartcase = true

-- Automatically reload files when they are changed outside of Neovim
vim.opt.autoread = true

-- Check for file changes when user returns to Neovim or when buffer gets focus
local autoread_group = vim.api.nvim_create_augroup("AutoRead", {
  clear = true
})
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = autoread_group,
  pattern = "*",
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
  desc = "Check for file changes when Neovim regains focus or buffer is entered"
})

local cursorLineAuGroup = vim.api.nvim_create_augroup("CursorLine", {
  clear = true
})
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  group = cursorLineAuGroup,
  callback = function()
    vim.opt_local.cursorline = true
  end
})
vim.api.nvim_create_autocmd({ "WinLeave" }, {
  group = cursorLineAuGroup,
  callback = function()
    vim.opt_local.cursorline = false
  end
})

-- For nagigatiion between windows
u.nmap("<C-h>", "<C-w>h")
u.nmap("<C-j>", "<C-w>j")
u.nmap("<C-k>", "<C-w>k")
u.nmap("<C-l>", "<C-w>l")

-- Quick save!
-- This ++p thing will ensure to create missing folders. Like mkdir -p
u.nmap("<leader><leader>", ":update ++p<CR>")

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

vim.api.nvim_set_hl(0, 'BlinkCmpGhostText', { fg = '#AAAAAA' })

-- Recommended by avante, but I don't feel it make sense
-- Too much sacriface for normal use as well
-- vim.opt.laststatus = 3

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = "󰋼 ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
    },
  },
  -- Only show virtual text if the severity is error
  virtual_text = {
    severity = vim.diagnostic.severity.ERROR,
    severity_sort = true,
    source = true
  }
})
