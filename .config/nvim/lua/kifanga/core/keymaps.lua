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

-- Function to clear Vim registers, excluding the system clipboard
function ClearRegisters()
    local registers = { "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s",
        "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-", }
    for _, reg in ipairs(registers) do vim.fn.setreg(reg, "") end
end

-- Autocmd clean up group on startup
local cleanup_group = vim.api.nvim_create_augroup("clean-up-group", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter" },
    { group = cleanup_group, command = "clearjumps", desc = "Automatically clear jump list on VimEnter", })

vim.api.nvim_create_autocmd({ "VimEnter" },
    {
        group = cleanup_group,
        callback = function() ClearRegisters() end,
        desc =
        "Automatically clear registers on VimEnter",
    })

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww fsession<CR>", { desc = "Tmux open project" })
vim.keymap.set("n", "<C-g>", "<cmd>silent !tmux neww fsingle<CR>", { desc = "Tmux open file" })

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
vim.keymap.set("n", "<leader>x", [["_x]], { desc = "Cut without affecting yank" })

vim.keymap.set("v", "<leader>d", [["_d]], { desc = "Delete without affecting yank" })
vim.keymap.set("v", "<leader>c", [["_c]], { desc = "Change without affecting yank" })

vim.keymap.set("n", "<C-a>", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<C-s>", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-e>", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<C-c>", "<C-w>c", { desc = "Close current split" })
vim.keymap.set("n", "<C-x>", "<C-w>o", { desc = "Close other splits" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
vim.keymap.set("n", "<leader>n", ":nohl<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "<leader>b", "<cmd>bufdo bd | enew<CR>", { desc = "Close all and open new buffer" })

vim.keymap.set("n", "<leader>q", "<Cmd>copen<CR>", { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>Q", "<Cmd>cclose<CR>", { desc = "Close quickfix list" })
-- The Quickfix list
-- ]q: Mapped to :cnext
-- [q: Mapped to :cprevious
-- [Q: Mapped to :crewind
-- ]Q: Mapped to :clast
-- :cwindow: Open the quickfix window when there are recognized errors

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
