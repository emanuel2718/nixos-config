local oil = require('oil')
local opts = { noremap = true, silent = true }
local map = vim.keymap.set

map("n", "-", oil.open, opts)

oil.setup({
  skip_confirm_for_simple_edits = true,
  use_default_keymaps = false,
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<C-k>"] = "k",
    ["<C-j>"] = "j",
    ["<C-h>"] = "actions.parent",
    ["<C-l>"] = "actions.select",
    ["<CR>"] = "actions.select",
    ["<C-r>"] = "actions.refresh",
    ["<C-c>"] = "actions.close",
    ["g."] = "actions.toggle_hidden",
    ["<C-m>"] = "actions.select_vsplit",
    ["<C-n>"] = "actions.select_split",
    ["gs"] = "actions.change_sort",
    ["_"] = "actions.open_cwd",
  },
  float = {
    padding = 4,
  },
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, bufnr)
      return vim.startswith(name, ".DS_Store")
    end,
  },
})