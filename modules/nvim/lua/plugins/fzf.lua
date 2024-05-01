local opts = { noremap = true, silent = true }
local map = vim.keymap.set

require("fzf-lua").setup({'max-perf'})

map("n", "<leader>.", "<cmd>FzfLua files<cr>", opts)
map("n", "<leader>sn", "<cmd>FzfLua files cwd=~/.config/nvim<cr>", opts)
map("n", "<leader>bi", "<cmd>FzfLua buffers<cr>", opts)
map("n", "<leader>so", "<cmd>FzfLua oldfiles<cr>", opts)
map("n", "<leader>sp", "<cmd>FzfLua live_grep_native<cr>", opts)
map("n", "<leader>sP", "<cmd>FzfLua grep<cr>", opts)
map("n", "<leader>ss", "<cmd>FzfLua grep_curbuf<cr>", opts)
map("n", "<leader>r.", "<cmd>FzfLua resume<cr>", opts)
map("n", "<leader>bt", "<cmd>FzfLua builtin<cr>", opts)
map("n", "<leader>hh", "<cmd>FzfLua helptags<cr>", opts)
map("n", "<leader>mt", "<cmd>FzfLua manpages<cr>", opts)
map("n", "<leader>ht", "<cmd>FzfLua colorschemes<cr>", opts)
