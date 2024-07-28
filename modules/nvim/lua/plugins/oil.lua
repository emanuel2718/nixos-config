require("oil").setup({
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-l>"] = "actions.select", -- custom
    ["<C-h>"] = "actions.parent", -- custom
    ["q"] = "actions.close", -- custom
    ["<C-c>"] = "actions.close",
    -- ["<C-l>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
    -- ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
    -- ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
    ["<C-p>"] = "actions.preview",
    ["<C-r>"] = "actions.refresh", -- custom
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["H"] = "actions.toggle_hidden", -- custom
    ["g\\"] = "actions.toggle_trash",
  },
  use_default_keymaps = false,
})

vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
