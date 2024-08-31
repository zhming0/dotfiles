local vim = vim

return {
  "olimorris/persisted.nvim",
  lazy = false, -- make sure the plugin is always loaded at startup
  config = function ()

    require('persisted').setup({
      use_git_branch = true,
      autoload = true, -- auto load session.
      on_autoload_no_session = function()
        vim.notify("No existing session to load.")
      end,
    })

    -- This is to ensure we don't persist things like terminal, clojure nrepl to the session
    vim.api.nvim_create_autocmd("User", {
      pattern = "PersistedSavePre",
      callback = function()
        local buffers = vim.api.nvim_list_bufs()

        for _, buf in ipairs(buffers) do
          if vim.api.nvim_buf_is_loaded(buf) then
            local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
            local modifiable = vim.api.nvim_buf_get_option(buf, "modifiable")

            if buftype ~= "" or not modifiable then
              vim.api.nvim_buf_delete(buf, { force = true })
            end
          end
        end
      end,
    })

  end,
}
