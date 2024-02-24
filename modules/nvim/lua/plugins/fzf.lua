local fzf = require('fzf-lua')
fzf.setup {}
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<leader>ff', function() fzf.files { previewer = false, hidden = true } end, opts)