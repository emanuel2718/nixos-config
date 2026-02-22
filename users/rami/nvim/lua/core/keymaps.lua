local utils = require("core.utils")
local map = vim.keymap.set

-- split and switch
map("n", "<leader>n", "<cmd>split<cr><c-w>w", { desc = "split window horizontally" })
map("n", "<leader>m", "<cmd>vsplit<cr><c-w>w", { desc = "split window vertically" })

-- movement
map("n", "<c-j>", "<c-w><c-j>", { desc = "move to window below" })
map("n", "<c-k>", "<c-w><c-k>", { desc = "move to window above" })
map("n", "<c-l>", "<c-w><c-l>", { desc = "move to window right" })
map("n", "<c-h>", "<c-w><c-h>", { desc = "move to window left" })

-- resize
map("n", "<Left>", "<c-w>5<", { desc = "decrease window width" })
map("n", "<Right>", "<c-w>5>", { desc = "increase window width" })
map("n", "<Up>", "<C-W>+", { desc = "increase window height" })
map("n", "<Down>", "<C-W>-", { desc = "decrease window height" })

-- move highlighted lines up and down
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selected lines up" })

-- Multiple indent commands
map("v", "<", "<gv", { desc = "indent left and keep selection" })
map("v", ">", ">gv", { desc = "indent right and keep selection" })

-- respect system clipboard
map("v", "<leader>y", [["+y]], { desc = "yank to system clipboard" })
map("n", "<leader>y", [["+Y]], { desc = "yank line to system clipboard" })

-- quit
map("n", "<leader>q", "<cmd>qa!<cr>", { desc = "quit all windows" })

-- save
map("n", "<leader>w", "<cmd>w!<cr>", { desc = "save file" })

-- close buffer
map("n", "<leader>o", "<cmd>q<cr>", { desc = "close current window" })

-- last buffer
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "open last buffer" })

-- send nvim to the foreground
map("n", "<C-g>", "<C-z>", { desc = "suspend nvim" })

-- highlight every line in the buffer
map("n", "<leader>a", "VggoG", { desc = "select all lines" })

-- don't yank pasted over text
map("v", "p", '"_dP', { desc = "paste without yanking" })

-- use <leader><tab> for toggling folds
map("n", "<leader><Tab>", "za", { desc = "toggle fold" })

map("n", "<s-h>", ":tabprevious<cr>", { desc = "Go to previous tab" })
map("n", "<s-l>", ":tabnext<cr>", { desc = "Go to next tab" })

-- Turn off search matches with double-<Esc>
-- map("n", "<Esc><Esc>", "<Esc>:nohlsearch<CR>", { silent = true, desc = "clear search highlights" })

-- reload neovim configuration
map("", "<leader>R", utils.reload_config, { silent = true, desc = "reload nvim configuration" })
