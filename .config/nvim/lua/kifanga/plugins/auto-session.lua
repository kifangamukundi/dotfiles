return {
    "rmagatti/auto-session",
    config = function()
        local auto_session = require("auto-session")

        auto_session.setup({
            auto_restore = false,
        })

        local map = vim.keymap.set

        map("n", "<leader>vR", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
        map("n", "<leader>vS", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
    end,
}
