return {
  "catgoose/nvim-colorizer.lua",
  ft = {
    "css",
    "scss",
    "sass",
    "html",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
  },
  config = function()
    require("colorizer").setup({
      filetypes = {
        "css",
        "scss",
        "sass",
        "html",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
      },
      user_default_options = {
        names = false,
        RGB = true,      -- #RGB hex codes
        RGBA = true,     -- #RGBA hex codes
        RRGGBB = true,   -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = true, -- 0xAARRGGBB hex codes
        rgb_fn = true,   -- CSS rgb() and rgba() functions
        hsl_fn = true,   -- CSS hsl() and hsla() functions
        tailwind = true,
      },
    })
    vim.keymap.set("n", "<leader>ci", "<cmd>ColorizerToggle<cr>", { desc = "Toggle colorizer" })
  end,
}
