return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = {
    "Neotree",
  },
  init = function()
    -- for neo-tree startup performance and correctness.
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  keys = {
    { "<leader>e", "<cmd>Neotree toggle filesystem right<cr>", desc = "Toggle file tree" },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
  end,
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = { "node_modules", ".vscode" },
      },
      group_empty_dirs = true,
    },
    window = {
      position = "right",
      mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
        ["g."] = "toggle_hidden",
      },
    },
  },
}
