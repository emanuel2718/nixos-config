local map = vim.keymap.set
local opts = { noremap = true, silent = true }
map("n", "<leader>;", function()
  return require("copilot.suggestion").toggle_auto_trigger()
end, opts)

require("copilot").setup {
  panel = {
    enabled = false,
    auto_refresh = false,
  },
  suggestion = {
    enabled = true,
    auto_trigger = false,
    debounce = 75,
    keymap = {
      accept = "<C-y>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 18.x
  server_opts_overrides = {},
}