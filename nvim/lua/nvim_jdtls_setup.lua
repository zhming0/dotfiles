-- The following parts largely are from:
-- https://github.com/neovim/nvim-lspconfig/blob/v0.1.6/lua/lspconfig/server_configurations/jdtls.lua
-- with some modification such as unique workspace url per project.
-- This setup might have some problem with single java file.
local function path_join(...)
  return table.concat(vim.tbl_flatten { ... }, '/')
end

local env = {
  HOME = vim.loop.os_homedir(),
  XDG_CACHE_HOME = os.getenv 'XDG_CACHE_HOME',
  JDTLS_JVM_ARGS = os.getenv 'JDTLS_JVM_ARGS',
}

local function get_cache_dir()
  return env.XDG_CACHE_HOME and env.XDG_CACHE_HOME or path_join(env.HOME, '.cache')
end

local function get_jdtls_cache_dir()
  return path_join(get_cache_dir(), 'jdtls')
end

local function get_jdtls_config_dir()
  return path_join(get_jdtls_cache_dir(), 'config_mac')
end

local function get_jdtls_workspace_dir(project_name)
  return path_join(get_jdtls_cache_dir(), 'workspace', project_name)
end

local function get_jdtls_jvm_args()
  local args = {}
  for a in string.gmatch((env.JDTLS_JVM_ARGS or ''), '%S+') do
    local arg = string.format('--jvm-arg=%s', a)
    table.insert(args, arg)
  end
  return unpack(args)
end

return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  config = function()
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
      pattern = { "*.java" },
      callback = function()
        -- There is a possibility that if I open two java files from two different workspace, it will cause conflict.
        -- So I think that I need to do is to get the root_dir detection to happen for each BufEnter
        -- But I never truly tested it.
        local root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1])
        local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
        local config = {
          cmd = {
            vim.fn.stdpath("data") .. "/mason/bin/jdtls",
            '-configuration', get_jdtls_config_dir(),
            '-data', get_jdtls_workspace_dir(project_name),
            get_jdtls_jvm_args()
          },
          root_dir = root_dir,

          settings = {
            java = {
              -- Do I need to do the same for mise?
              -- home = path_join(env.HOME, ".asdf/installs/java/openjdk-21")
            }
          }
        }
        -- Do I need to do the same for mise?
        -- vim.fn.setenv("JAVA_HOME", path_join(env.HOME, ".asdf/installs/java/openjdk-21"))
        require('jdtls').start_or_attach(config)
      end
    })
  end
}
