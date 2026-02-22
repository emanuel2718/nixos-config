vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.mouse = "a"
opt.wrap = false
opt.inccommand = "split"
opt.cursorline = true
opt.number = true
opt.numberwidth = 1
opt.showmode = false
opt.showtabline = 2

opt.tabstop = 2
opt.shiftwidth = 2
opt.shiftround = true
opt.expandtab = true
opt.smartindent = true

opt.signcolumn = "yes"
opt.colorcolumn = "100"
opt.synmaxcol = 300

opt.foldlevel = 99
opt.foldmethod = "indent"
opt.foldenable = true

opt.ignorecase = true
opt.smartcase = true

opt.hlsearch = false
opt.incsearch = true

opt.swapfile = false
opt.backup = false

opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
opt.undofile = true

opt.scrolloff = 8
opt.updatetime = 250
opt.autoread = true
opt.exrc = true
opt.secure = true

opt.list = true
opt.listchars = {
  tab = "^ ",
  nbsp = "¬",
  trail = "·",
  extends = "»",
  precedes = "«",
}
opt.showbreak = "↪ "
