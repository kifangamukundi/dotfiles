vim.pack.add({
    {
        src = "https://github.com/rmagatti/auto-session",
        name = "auto-session",
    },
})

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("kifanga-auto-session-setup", { clear = true }),
    callback = function()
        local auto_session = require("auto-session")

        auto_session.setup({
            auto_restore = false,
        })

        vim.keymap.set("n", "<leader>r", "<cmd>AutoSession restore<CR>", { desc = "Restore session for cwd" })
        vim.keymap.set("n", "<leader>s", "<cmd>AutoSession save<CR>", { desc = "Save session for auto session root dir" })
    end,
})
