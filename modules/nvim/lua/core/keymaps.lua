local opts = { noremap = true, silent = true }
local map = vim.keymap.set

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- split windows
map("n", "<leader>n", "<cmd>split<cr>", opts)
map("n", "<leader>m", "<cmd>vsplit<cr>", opts)

-- close buffer
map("n", "<leader>k", "<cmd>q<cr>", opts)

-- window movement
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- window resize
map("n", "<Up>", ":resize +2<cr>", opts)
map("n", "<Down>", ":resize -2<cr>", opts)
map("n", "<Left>", ":vertical resize +2<cr>", opts)
map("n", "<Right>", ":vertical resize -2<cr>", opts)

-- move highlighted lines up and down
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Multiple indent commands
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- respect system clipboard
map("v", "<leader>y", [["+y]], opts)
map("n", "<leader>y", [["+Y]], opts)

-- clear highlights
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", opts)


-- don't mess with the yank register on paste
map("x", "p", [["_dP]])

-- General
map("n", "<leader>q", ":qa!<cr>", opts)
map("n", "<leader>fs", ":w!<cr>")
map("n", "<leader>`", ":e #<cr>", opts)
map("n", "<C-f>", ":e ")