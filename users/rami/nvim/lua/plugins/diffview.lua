return {
  "sindrets/diffview.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewFocusFiles", "DiffviewToggleFiles" },
  config = function()
    require("diffview").setup({
      view = {
        default = {
          layout = "diff2_horizontal",
        },
      },
    })
  end,
  keys = {
    { "<leader>d.", "<cmd>DiffviewOpen<cr>", desc = "Open diffview" },
    { "<leader>do", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
    { "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
  },
}
