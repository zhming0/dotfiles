return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
    'saadparwaiz1/cmp_luasnip', -- cmp sources from LuaSnip
    'L3MON4D3/LuaSnip', -- Snippets plugin
    'ray-x/cmp-treesitter', -- Sources for nvim-cmp
    'hrsh7th/cmp-emoji', -- Sources for nvim-cmp
  },
  config = function()
    -- luasnip setup
    local luasnip = require 'luasnip'
    require("luasnip.loaders.from_vscode").lazy_load()

    -- nvim-cmp setup
    local cmp = require 'cmp'
    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      experimental = {
        ghost_text = true,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
        ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
        -- C-b (back) C-f (forward) for snippet placeholder navigation.
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'treesitter' }, -- https://github.com/ray-x/cmp-treesitter
        { name = 'emoji' }, -- https://github.com/hrsh7th/cmp-emoji ✅
      },
    }
  end
}
