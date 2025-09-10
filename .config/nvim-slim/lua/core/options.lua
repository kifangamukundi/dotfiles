vim.g.mapleader = " "
vim.g.mapleader = " "

local opt = vim.opt

opt.tabstop = 4

opt.shiftwidth = 4

opt.expandtab = true

opt.autoindent = true

opt.smartindent = true

opt.wrap = false

opt.swapfile = false

opt.undodir = vim.fn.stdpath("cache") .. "/undo"
opt.undofile = true

opt.hidden = true

opt.ignorecase = true

opt.smartcase = true

opt.cursorline = true

opt.scrolloff = 8

opt.sidescrolloff = 8

opt.clipboard = ""

opt.termguicolors = true

opt.background = "dark"

opt.signcolumn = "yes"

opt.winborder = "rounded"

opt.ruler = true

opt.laststatus = 2

opt.relativenumber = true

opt.number = true

opt.colorcolumn = ""

opt.lazyredraw = false

opt.updatetime = 100

opt.timeoutlen = 2000

opt.ttimeoutlen = 100

opt.backspace = "indent,eol,start"

opt.mouse = ""

opt.wildmenu = true

opt.wildmode = "longest:full,full"

opt.showmatch = true

opt.matchtime = 2

opt.errorbells = false

opt.visualbell = true

opt.backup = false

opt.writebackup = false

opt.virtualedit = "block"

opt.splitbelow = true

opt.splitright = true
