local FORCE_REMOTE = false
local local_vanta_path = vim.fn.expand("$HOME/git/vanta.nvim")
local uv = vim.uv or vim.loop
local has_local_vanta = uv and uv.fs_stat(local_vanta_path) ~= nil
local use_remote = FORCE_REMOTE or not has_local_vanta

return {
  use_remote and "emanuel2718/vanta.nvim" or nil,
  dir = not use_remote and local_vanta_path or nil,
  priority = 1000,
  config = function()
    require("vanta").setup({
      -- Enable terminal colors (recommended)
      terminal_colors = true,

      -- Style options
      undercurl = false, -- Use undercurls for diagnostics and spellcheck
      underline = false, -- Use underlines for references and matching words
      bold = false, -- Use bold for headings, keywords, and UI elements

      -- Window appearance
      dim_inactive = false, -- Dim text in inactive windows
      transparent = false, -- Use transparent backgrounds

      -- Italic options
      italic = {
        strings = false, -- Italicize strings
        comments = false, -- Italicize comments
        operators = false, -- Italicize operators
        emphasis = false, -- Italicize emphasized text
        folds = true, -- Italicize fold markers
      },
    })
    vim.cmd.colorscheme("vanta")
  end,
}
