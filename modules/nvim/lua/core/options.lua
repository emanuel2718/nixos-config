local opt = vim.opt

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

opt.termguicolors = true

opt.undofile = true

opt.hlsearch = true
opt.smartcase = true
opt.number = true
opt.mouse = 'a'
opt.showcmd = false
opt.showmode = false
opt.cursorline = true

opt.list = true

opt.updatetime = 250 -- faster completion (4000ms default)
opt.timeoutlen = 300

opt.expandtab = true -- tabs -> spaces
opt.tabstop = 2
opt.shiftwidth = 2

opt.cmdheight = 1
opt.wrap = false

opt.scrolloff = 10
opt.sidescrolloff = 8

opt.writebackup = false
opt.swapfile = false

opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
}
opt.fillchars = {
  eob = " ", -- Suppress ~ at EndOfBuffer
  fold = " ", -- Hide trailing folding characters
  diff = "╱",
  foldopen = "",
  foldclose = "",
}
