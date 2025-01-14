local M = {}
local vim = vim

-- We cache the results of "git rev-parse"
-- Process creation is expensive in Windows, so this reduces latency
local repo_type = {}

M.project_files = function()
  local opts = {} -- define here if you want to define something

  local cwd = vim.fn.getcwd()
  if repo_type[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    if vim.v.shell_error == 0 then
      repo_type[cwd] = 'git'
    end

    vim.fn.system("jj st")
    if vim.v.shell_error == 0 then
      repo_type[cwd] = 'jj'
    end

    if repo_type[cwd] == nil then
      repo_type[cwd] = false -- meaning current cwd is not a repository
    end
  end

  if repo_type[cwd] == 'git' then
    require("telescope.builtin").git_files(opts)
  elseif repo_type[cwd] == 'jj' then
    require("telescope.builtin").git_files {
      prompt_title = "Jujutsu Files",
      git_command = { "jj", "file", "list", "--no-pager" },
    }
  else
    require("telescope.builtin").find_files(opts)
  end
end

return M
