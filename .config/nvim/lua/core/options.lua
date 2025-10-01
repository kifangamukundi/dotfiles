local opt = vim.opt

-- Set a tab character to be 4 spaces wide
opt.tabstop = 4

-- The number of spaces to use for each step of (auto)indent
opt.shiftwidth = 4

-- Use spaces instead of tabs
opt.expandtab = true

-- Copy indent from the previous line
opt.autoindent = true

-- Smartly insert indents in new lines
opt.smartindent = true

-- Disable text wrapping
opt.wrap = false

-- Disable creating swap files
opt.swapfile = false

-- Set undo directory
opt.undodir = vim.fn.stdpath("cache") .. "/undo"
opt.undofile = true

-- Allow for hidden buffers
opt.hidden = true

-- Ignore case in search patterns
opt.ignorecase = true

-- Override `ignorecase` if the search pattern contains an uppercase letter
opt.smartcase = true

-- Highlight the current line
opt.cursorline = true

-- Number of screen lines to keep above and below the cursor
opt.scrolloff = 8

-- Number of screen columns to keep to the left and right of the cursor
opt.sidescrolloff = 8

-- opt.clipboard:append("unnamedplus") -- Use the system clipboard for all operations
-- Explicitly disable system clipboard integration
opt.clipboard = ""

-- Enable 24-bit color support
opt.termguicolors = true

-- Use a dark background
opt.background = "dark"

-- Show the sign column only when needed
opt.signcolumn = "yes"

-- Use rounded corners for window borders
opt.winborder = "rounded"

-- Show the cursor position in the status line
opt.ruler = true

-- Always show the status line
opt.laststatus = 2

-- Use relative line numbers
opt.relativenumber = true

-- Show the absolute line number
opt.number = true

-- Highlight column 80 for line length guide
opt.colorcolumn = ""

-- Redraw immediately (can be CPU-intensive, but faster feedback)
opt.lazyredraw = false

-- Time in ms to wait for `CursorHold` events
opt.updatetime = 100

-- Time in ms to wait for a mapped sequence
opt.timeoutlen = 2000

-- Time in ms to wait for key codes
opt.ttimeoutlen = 100

-- Allow backspace over everything
opt.backspace = "indent,eol,start"

-- Mouse support (options available: empty, a, n, v, i, c, h, r)
-- Disable mouse support
opt.mouse = ""

-- Turn on wildmenu for command-line completion
opt.wildmenu = true

-- Wildmode completion behavior
opt.wildmode = "longest:full,full"

-- Show matching brackets
opt.showmatch = true

-- Time in tenths of a second to show the match
opt.matchtime = 2

-- Disable error bells
opt.errorbells = false

-- Use a visual bell instead of an audible one
opt.visualbell = true

-- Do not create backup files
opt.backup = false

-- Do not create a backup before writing a file
opt.writebackup = false

-- Allow block-visual mode to select on virtual lines
opt.virtualedit = "block"

-- horizontal splits go below
opt.splitbelow = true

-- vertical splits go to the right
opt.splitright = true

-- Thin listing: just the current directory
vim.g.netrw_liststyle = 0

-- Numbers and relative numbers
vim.g.netrw_bufsettings = 'nu rnu'

-- Hide the help banner
vim.g.netrw_banner = 0

-- Use current buffer
vim.g.netrw_browse_split = 0

-- Avoid vertical splits
vim.g.netrw_altv = 1
