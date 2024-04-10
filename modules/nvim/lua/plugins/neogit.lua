local opts = { noremap = true, silent = true }
local map = vim.keymap.set

map('n', '<leader>g.', '<cmd>Neogit<cr>', opts)

require('neogit').setup({
  auto_refresh = false,
  signs = {
    -- { CLOSED, OPENED }
    section = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
    item = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
    hunk = { "", "" },
  },
  integrations = {
    diffview = true,
    fzf_lua = true
  },
})