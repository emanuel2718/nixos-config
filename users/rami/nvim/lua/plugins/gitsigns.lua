return {
  "lewis6991/gitsigns.nvim",
  -- "VeryLazy" hides splash screen
  event = "BufReadPre",
  config = function()
    require("gitsigns").setup({
      max_file_length = 20000,
      signs = { change = { text = "┋" } },
      signs_staged = { change = { text = "┋" } },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end
        map("n", "<leader>gj", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, { desc = "next git hunk" })
        map("n", "<leader>gk", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, { desc = "previous git hunk" })
        map("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "toggle inline git blame" })
        map("n", "<leader>hp", gs.preview_hunk_inline, { desc = "preview hunk (inline)" })
        map("n", "<leader>hP", gs.preview_hunk, { desc = "preview hunk (float)" })
      end,
    })
  end,
}
