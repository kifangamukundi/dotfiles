vim.pack.add({
    {
        src = "https://github.com/rmagatti/auto-session",
        name = "auto-session",
    },
})

local ok, auto_session = pcall(require, "auto-session")
if not ok then return end

auto_session.setup({
    auto_restore = false,
})

vim.keymap.set("n", "<leader>r", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
vim.keymap.set("n", "<leader>s", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })

