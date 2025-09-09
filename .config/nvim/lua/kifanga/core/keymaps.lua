vim.g.mapleader = " "
vim.g.mapleader = " "

-- Disable arrow keys in all modes
local modes = { "n", "i", "v", "s", "c", "t" }
local arrows = { "<Up>", "<Down>", "<Left>", "<Right>" }

for _, mode in ipairs(modes) do
    for _, arrow in ipairs(arrows) do
        vim.keymap.set(mode, arrow, "<Nop>", { noremap = true })
    end
end

-- Disable substitute command
vim.keymap.set({ "n", "v" }, "s", "<Nop>")
vim.keymap.set({ "n", "v" }, "S", "<Nop>")

vim.keymap.set("n", "Q", "<Nop>")

vim.keymap.set("i", "<C-[>", "<Esc>", { silent = true, desc = "Exit Insert mode" })

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww fsession<CR>", { desc = "Tmux open project" })
vim.keymap.set("n", "<C-b>", "<cmd>silent !tmux neww fmusic<CR>", { desc = "Tmux open project" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Searching and centering activate while on word with * or #
vim.keymap.set("n", "n", "nzz", { desc = "Search moving forward or backward" })
vim.keymap.set("n", "N", "Nzz", { desc = "Search moving forward or backward" })

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "H", ":t '<-1<CR>gv=gv", { desc = "Duplicate selected lines up" })
vim.keymap.set("v", "L", ":t '><CR>gv=gv", { desc = "Duplicate selected lines down" })

vim.keymap.set("v", "<", "<gv", { desc = "Shift selection left and reselect it" })
vim.keymap.set("v", ">", ">gv", { desc = "Shift selection right and reselect it" })

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over selection (preserve yank)" })
vim.keymap.set("x", "<leader>P", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("n", "<leader>p", [["+p]], { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank entire line to clipboard" })
vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete with motion (no yank)" })
vim.keymap.set("n", "<leader>c", '"_c', { desc = "Change with motion (no yank)" })

vim.keymap.set("v", "<leader>d", [["_d]], { desc = "Delete without affecting yank" })
vim.keymap.set("v", "<leader>c", [["_c]], { desc = "Change without affecting yank" })

vim.keymap.set("n", "<leader>b", "<cmd>bufdo bd | enew<CR>", { desc = "Close all and open new buffer" })

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })
vim.keymap.set("n", "<leader>X", "<cmd>!chmod -x %<CR>", { silent = true, desc = "Remove executable permission" })

vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- <C-a> → Increment number under cursor
-- <C-b> → Scroll back one full screen
-- <C-c> → Interrupt / cancel (like <Esc>)
-- <C-d> → Scroll down half a screen
-- <C-e> → Scroll window down one line
-- <C-f> → Scroll forward one full screen
-- <C-g> → Show cursor position and file info
-- <C-h> → Backspace in Insert mode (delete before cursor)
-- <C-i> → Jump forward in the jump list (same as <Tab>)
-- <C-j> → Line break in Insert mode
-- <C-k> → In Insert mode, delete to end of line (part of digraphs too)
-- <C-l> → Redraw screen, remove search highlighting
-- <C-m> → Same as <CR> (Enter)
-- <C-n> → Insert mode: next completion match
-- <C-o> → Jump backward in the jump list
-- <C-p> → Insert mode: previous completion match
-- <C-q> → In some setups, start recording literal control codes (can also freeze terminal if flow control is on)
-- <C-r> → Redo last change
-- <C-t> → Insert mode: decrease indent
-- <C-u> → Scroll up half a screen
-- <C-v> → Insert next literal character (quote a key)
-- <C-w> → Window command prefix (split management)
-- <C-x> → Decrement number under cursor
-- <C-y> → Scroll window up one line
-- <C-z> → Suspend Vim (send to background, job control)

-- <C-w>c → Close current window
-- <C-w>o → Close all other windows ("only")
-- <C-w>s → Split window horizontally
-- <C-w>v → Split window vertically
-- <C-w>= → Make all windows equal size
-- <C-w>+ → Increase window height
-- <C-w>- → Decrease window height
-- <C-w>< → Decrease window width
-- <C-w>> → Increase window width

-- <C-w>h → Move to left window
-- <C-w>j → Move to below window
-- <C-w>k → Move to above window
-- <C-w>l → Move to right window
-- <C-w>w → Cycle through windows
-- <C-w>p → Jump to previous window
-- <C-w>t → Jump to top-left window
-- <C-w>b → Jump to bottom-right window

-- <C-w>K → Move window to top (full-height)
-- <C-w>J → Move window to bottom (full-height)
-- <C-w>H → Move window to far left (full-width)
-- <C-w>L → Move window to far right (full-width)

-- <C-w>T → Break window into its own tab page
-- <C-w>n → Open new empty window (same as :new)
-- <C-w>q → Quit current window (same as :quit)

-- <C-w>x → Exchange current window with next
-- <C-w>r → Rotate windows downwards/rightwards
-- <C-w>R → Rotate windows upwards/leftwards
-- <C-w>O → Close all other windows in the current tab
-- <C-w>z → Close preview window
-- <C-w>P → Go to preview window
-- <C-w>f → Edit file name under cursor in a new window
-- <C-w>F → Edit file under cursor in a new window (jump to line)
-- <C-w>} → Show tag under cursor in preview window
-- <C-w>] → Jump to tag under cursor in a new window
-- <C-w>^ → Jump to alternate file in new window
-- <C-w>_ → Maximize current window height
-- <C-w>| → Maximize current window width

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
vim.keymap.set("n", "<leader>n", ":nohl<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "<leader>va", "<cmd>bufdo bd | enew<CR>", { desc = "Close all and open new buffer" })

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>q", "<Cmd>copen<CR>", { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>Q", "<Cmd>cclose<CR>", { desc = "Close quickfix list" })
-- The Quickfix list
-- ]q: Mapped to :cnext
-- [q: Mapped to :cprevious
-- [Q: Mapped to :crewind
-- ]Q: Mapped to :clast
-- :cwindow: Open the quickfix window when there are recognized errors

vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")
vim.keymap.set("n", "<leader>l", "<Cmd>lopen<CR>", { desc = "Open loclist list" })
vim.keymap.set("n", "<leader>L", "<Cmd>lclose<CR>", { desc = "Close loclist list" })
-- The loclist list
-- ]l: Mapped to :lnext
-- [l: Mapped to :lprevious
-- [L: Mapped to :lrewind
-- ]L: Mapped to :llast
-- :lwindow: Open the loclist window when there are recognized errors

-- ]d jumps to the next diagnostic in the buffer.
-- [d jumps to the previous diagnostic in the buffer.
-- ]D jumps to the last diagnostic in the buffer.
-- [D jumps to the first diagnostic in the buffer.

-- Use = sign with motions to format according to rules
-- Use gv to restore the previously visual selection
-- use O to switch the ends for selections
-- use gu or gU with motion to change case
-- Select a list of items then put them in one line with gJ

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost",
    {
        desc = "Highlight when yanking (copying) text",
        group = vim.api.nvim_create_augroup("kickstart-highlight-yank",
            { clear = true }),
        callback = function() vim.hl.on_yank() end,
    })

-- Yank
-- "{register}y{motion/text_object}
-- Works with 'a' through 'z', 'A' through 'Z', '0' through '9',
-- and special registers: ", +, *, _

-- Delete
-- "{register}d{motion/text_object}
-- Works with 'a' through 'z', 'A' through 'Z', '1' through '9',
-- and special registers: ", +, *, _

-- Paste
-- "{register}p    put after cursor
-- "{register}P    put before cursor
-- Works with 'a' through 'z', 'A' through 'Z', '0' through '9',
-- and special registers: ", %, #, :, ., /, +, *

-- Replace
-- "{register}r{char}
-- Works with 'a' through 'z', 'A' through 'Z', '0' through '9',
-- and special registers: ", %, /, :, ., +, *
