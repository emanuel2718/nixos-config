---@diagnostic disable: unused-local
---@diagnostic disable: unused-function


local colorGruvbox = function()
  vim.cmd [[ colorscheme gruvbox ]]
  vim.g.gruvbox_italic = 0
  vim.g.gruvbox_bold = 1
  vim.g.gruvbox_termcolors = 256
  vim.g.gruvbox_contrast_dark = "hard"
  vim.g.gruvbox_invert_selection = 0
end


local highlight = function()
  -- blue highlight in cmp menu
  vim.cmd [[highlight PmenuSel guibg=blue guifg=white]]

  -- blue cursor in telescope
  vim.cmd [[highlight TelescopeSelection guibg=blue]]

  vim.cmd [[ highlight LineNr guibg=NONE ctermbg=NONE ]]
  vim.cmd [[ highlight SignColumn guibg=NONE ctermbg=NONE ]]
end


local colorHybrid = function()
  local background = "#000000"
  -- local background = "#0e1111"
  require("hybrid").setup({
    terminal_colors = true,
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
      strings = false,
      emphasis = true,
      comments = true,
      folds = true,
    },
    strikethrough = true,
    inverse = true,
    transparent = false,
    overrides = function(hl, c)
      c.bg = background
      hl.TelescopeNormal = {
        fg = c.fg,
        bg = background,
      }
      hl.TelescopeBorder = {
        fg = c.fg,
        bg = c.bg,
      }
      hl.TelescopeTitle = {
        fg = c.fg_hard,
        bg = c.bg,
        bold = true,
      }
    end,
  })
  vim.cmd [[colorscheme hybrid]]
  vim.api.nvim_set_hl(0, "Normal", { bg = background })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = background })
  vim.api.nvim_set_hl(0, "@markup.heading", { bold = true })
  vim.api.nvim_set_hl(0, "@markup.raw.block", { fg = nil })
end

colorHybrid()
highlight()
