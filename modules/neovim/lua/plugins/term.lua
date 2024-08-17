require('toggleterm').setup({ direction = 'float' })
vim.keymap.set('n', '<c-t>', '<cmd>ToggleTerm<cr>', { noremap = true, silent = true })
vim.keymap.set('t', '<c-t>', '<cmd>ToggleTerm<cr>', { noremap = true, silent = true })
