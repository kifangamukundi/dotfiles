local modes = { "n", "i", "v", "s", "c", "t" }
local arrows = { "<Up>", "<Down>", "<Left>", "<Right>" }

for _, mode in ipairs(modes) do
    for _, arrow in ipairs(arrows) do
        vim.keymap.set(mode, arrow, "<Nop>", { noremap = true })
    end
end

vim.keymap.set({ "n", "v" }, "s", "<Nop>")
vim.keymap.set({ "n", "v" }, "S", "<Nop>")

vim.keymap.set("n", "Q", "<Nop>")

vim.keymap.set("i", "<C-[>", "<Esc>", { silent = true, desc = "Exit Insert mode" })

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww fsession<CR>", { desc = "Tmux open project" })
vim.keymap.set("n", "<C-b>", "<cmd>silent !tmux neww fmusic<CR>", { desc = "Tmux open project" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

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

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
vim.keymap.set("n", "<leader>n", ":nohl<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "<leader>va", "<cmd>bufdo bd | enew<CR>", { desc = "Close all and open new buffer" })

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>q", "<Cmd>copen<CR>", { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>Q", "<Cmd>cclose<CR>", { desc = "Close quickfix list" })

vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")
vim.keymap.set("n", "<leader>l", "<Cmd>lopen<CR>", { desc = "Open loclist list" })
vim.keymap.set("n", "<leader>L", "<Cmd>lclose<CR>", { desc = "Close loclist list" })
