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

-- The "+ register" is the vim equivalent to a CTRL+C in another program, while the "* register" is the "mouse selection and middle click" equivalent (in a Gnu/Linux OS).
-- Function to clear Vim registers, excluding the system clipboard
function ClearRegisters()
    local registers = {
        "a",
        "b",
        "c",
        "d",
        "e",
        "f",
        "g",
        "h",
        "i",
        "j",
        "k",
        "l",
        "m",
        "n",
        "o",
        "p",
        "q",
        "r",
        "s",
        "t",
        "u",
        "v",
        "w",
        "x",
        "y",
        "z",
        "0",
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "-",
    }
    for _, reg in ipairs(registers) do
        vim.fn.setreg(reg, "")
    end
end

-- Autocmd clean up group on startup
local cleanup_group = vim.api.nvim_create_augroup("clean-up-group", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    group = cleanup_group,
    command = "clearjumps",
    desc = "Automatically clear jump list on VimEnter",
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    group = cleanup_group,
    callback = function()
        ClearRegisters()
    end,
    desc = "Automatically clear registers on VimEnter",
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

vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sf", "<C-w>_", { desc = "Make split full screen" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
vim.keymap.set("n", "<leader>n", ":nohl<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "<leader>bc", "<cmd>bufdo bd | enew<CR>", { desc = "Close all and open new buffer" })

-- The Quickfix list helps you jump to a list of places
-- (like all errors in your project or all results from a big search)
-- that apply to your entire Neovim session.
--For the following references, workspace symbols
vim.keymap.set("n", "<leader>qn", function()
    local qflist = vim.fn.getqflist()
    if #qflist == 0 then
        vim.notify("Quickfix List is empty", vim.log.levels.INFO, { title = "Quickfix List" })
        return
    end
    if not pcall(vim.cmd.cnext) then
        pcall(vim.cmd.cfirst)
    end
end, { desc = "Next quickfix item (wrap)" })

vim.keymap.set("n", "<leader>qp", function()
    local qflist = vim.fn.getqflist()
    if #qflist == 0 then
        vim.notify("Quickfix List is empty", vim.log.levels.INFO, { title = "Quickfix List" })
        return
    end
    if not pcall(vim.cmd.cprevious) then
        pcall(vim.cmd.clast)
    end
end, { desc = "Previous quickfix item (wrap)" })

vim.keymap.set("n", "<leader>qx", "<Cmd>cclose<CR>", { desc = "Close quickfix list" })
vim.keymap.set("n", "<leader>qo", "<Cmd>copen<CR>", { desc = "Open quickfix list" })

vim.keymap.set("n", "<leader>qc", function()
    local qflist = vim.fn.getqflist()
    if #qflist == 0 then
        vim.notify("Quickfix List is empty", vim.log.levels.INFO, { title = "Quickfix List" })
    else
        vim.fn.setqflist({})
        vim.notify("Quickfix cleared", vim.log.levels.INFO, { title = "Quickfix List" })
    end
end, { desc = "Clear quickfix list" })

-- The Location list is similar to the Quickfix list
-- but is just for the errors or search results in the specific file
-- you're looking at right now
-- For the following diagnostics, document symbols
vim.keymap.set("n", "<leader>ln", function()
    local loclist = vim.fn.getloclist(0)
    if #loclist == 0 then
        vim.notify("Location List is empty", vim.log.levels.INFO, { title = "Location List" })
        return
    end
    if not pcall(vim.cmd.lnext) then
        pcall(vim.cmd.lfirst)
    end
end, { desc = "Next location item (wrap)" })

vim.keymap.set("n", "<leader>lp", function()
    local loclist = vim.fn.getloclist(0)
    if #loclist == 0 then
        vim.notify("Location List is empty", vim.log.levels.INFO, { title = "Location List" })
        return
    end
    if not pcall(vim.cmd.lprevious) then
        pcall(vim.cmd.llast)
    end
end, { desc = "Previous location item (wrap)" })

vim.keymap.set("n", "<leader>lx", "<Cmd>lclose<CR>", { desc = "Close location list" })

vim.keymap.set("n", "<leader>lo", function()
    vim.diagnostic.setloclist({
        open = true,
        severity_sort = true,
    })
    local loclist_items = vim.fn.getloclist(0)
    if #loclist_items == 0 then
        vim.notify("Location List is empty, no diagnostics found.", vim.log.levels.INFO, { title = "Diagnostics" })
    end
end, { desc = "Open Location List (Diagnostics)" })

-- Use = sign with motions to format according to rules
-- Use gv to restore the previously visual selection
-- use O to switch the ends for selections
-- use gu or gU with motion to change case
-- Select a list of items then put them in one line with gJ
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#212121" })
        vim.api.nvim_set_hl(0, "Visual", { bg = "#3c3c3c" })

        vim.api.nvim_set_hl(0, "Search", { bg = "#3c3c3c", fg = "#ffffff", bold = true })
        vim.api.nvim_set_hl(0, "IncSearch", { bg = "#5f5faf", fg = "#ffffff", bold = true })
        vim.api.nvim_set_hl(0, "MatchParen", { bg = "#444444", fg = "#ffffff", bold = true })

        -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        -- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Yank into a NAMED register (general purpose): <leader>r{lowercase_register_name}y{motion/text_object}
for i = 97, 122 do -- ASCII values for 'a' through 'z'
    local char = string.char(i)
    vim.keymap.set(
        { "n", "v" },
        "<leader>r" .. char .. "y",
        '"' .. char .. "y",
        { desc = "Yank to register '" .. char .. "'" }
    )
end

-- Append to a NAMED register: <leader>r{uppercase_register_name}y{motion/text_object}
for i = 65, 90 do -- ASCII values for 'A' through 'Z'
    local char = string.char(i)
    vim.keymap.set(
        { "n", "v" },
        "<leader>r" .. char .. "y",
        '"' .. char .. "y",
        { desc = "Append yank to register '" .. string.lower(char) .. "'" }
    )
end

-- Delete into a NAMED register: <leader>r{lowercase_register_name}d{motion/text_object}
for i = 97, 122 do -- ASCII values for 'a' through 'z'
    local char = string.char(i)
    vim.keymap.set(
        { "n", "v" },
        "<leader>r" .. char .. "d",
        '"' .. char .. "d",
        { desc = "Delete to register '" .. char .. "'" }
    )
end

-- Delete to a NAMED register and APPEND: <leader>r{uppercase_register_name}d{motion/text_object}
for i = 65, 90 do -- ASCII values for 'A' through 'Z'
    local char = string.char(i)
    vim.keymap.set(
        { "n", "v" },
        "<leader>r" .. char .. "d",
        '"' .. char .. "d",
        { desc = "Append delete to register '" .. string.lower(char) .. "'" }
    )
end

-- Paste from any register: <leader>r{register_name}p (paste after)
-- <leader>r{register_name}P (paste before)
-- This includes named, numbered, system, and special registers.
-- Note: 'A' or 'B' are uppercase, but when pasting, it refers to the content of 'a' or 'b'.
local all_paste_registers = {
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "-", -- small delete register
    "*", -- primary selection
    "+", -- system clipboard
    ".", -- last inserted text
    "%", -- current file name
    "#", -- alternate file name
    ":", -- last command-line command
    "_", -- black hole (though pasting from it is usually pointless, included for completeness)
    -- No need to map " as it's the default paste
}

for _, reg in ipairs(all_paste_registers) do
    vim.keymap.set(
        { "n", "v" },
        "<leader>r" .. reg .. "p",
        '"' .. reg .. "p",
        { desc = "Paste from register '" .. reg .. "'" }
    )
    vim.keymap.set(
        { "n", "v" },
        "<leader>r" .. reg .. "P",
        '"' .. reg .. "P",
        { desc = "Paste from register '" .. reg .. "' (before)" }
    )
end
