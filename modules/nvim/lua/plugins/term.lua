require('toggleterm').setup {
  direction = 'float'
}
vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm<cr>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-t>", "<cmd>ToggleTerm<cr>", { noremap = true, silent = true })
