local map = vim.keymap.set
local fzf = require('fzf-lua')

fzf.setup({
  {'fzf-native'},
  winopts = {
    preview = { hidden = "hidden" },
    height = 0.5,
    width = 1,
    row = 1,
    col = 0.5,
    border = "rounded",
    winblend = 10,
  },
  -- files = { formatter = "path.filename_first" },
})

map('n', '<leader>.', fzf.files)
map('n', '<leader>fo', fzf.oldfiles)
map('n', '<leader>sp', fzf.live_grep)
map('n', '<leader>si', fzf.lsp_document_symbols)
map('n', '<leader><leader>', fzf.buffers)

map('n', '<leader>r.', fzf.resume)
map('n', '<leader>hh', fzf.helptags)
map('n', '<leader>ht', fzf.colorschemes)
