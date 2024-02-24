local cmp = require 'cmp'
local luasnip = require 'luasnip'
luasnip.config.setup {}

require("tailwindcss-colorizer-cmp").setup({
  color_square_width = 2,
})


cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = { completeopt = 'menu,menuone,noinsert' },

  mapping = cmp.mapping.preset.insert {
    ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
    ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<Enter>'] = cmp.mapping.confirm { select = true },
    ['<C-Space>'] = cmp.mapping.complete {},
    ["<C-h>"] = function()
      if cmp.visible_docs() then
        cmp.close_docs()
      else
        cmp.open_docs()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
  view = {
    docs = { auto_open = false },
  }
}
