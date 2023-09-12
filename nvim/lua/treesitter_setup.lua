
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "VeryLazy",
  config = function ()
    require'nvim-treesitter.configs'.setup {
      ensure_installed = "all",
      ignore_install = { "norg", "phpdoc" }, -- List of parsers to ignore installing
      highlight = {
        enable = true,              -- false will disable the whole extension
        disable = { },  -- list of language that will be disabled
      },
      indent = {
        enable = true
      }
    }
  end
}

