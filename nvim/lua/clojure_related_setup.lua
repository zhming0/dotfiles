local vim = vim

vim.g["conjure#log#hud#height"] = 1
vim.g["conjure#log#hud#width"] = 1
vim.g["conjure#log#log#wrap"] = "true"
-- Disable Conjure's K shortcut in favor of LSP's support
-- TODO need test
vim.g["conjure#mapping#doc_word"] = false

-- We have baleia to render color!
vim.g["conjure#log#strip_ansi_escape_sequences_line_limit"] = 0

-- disable auto-pair for clojure in favor of parinfer
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = {"*.clj", "*.cljs"},
  callback = function ()
    vim.g.AutoPairsShortcutToggle = false
  end
})
