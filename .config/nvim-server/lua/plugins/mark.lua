vim.pack.add({
    {
        src = "https://github.com/chentoast/marks.nvim",
        name = "marks.nvim",
    },
})

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("kifanga-marks-setup", { clear = true }),
    callback = function()
        local marks = require("marks")

        marks.setup({
            default_mappings = false,
            signs = true,
        })

        vim.keymap.set("n", "<leader>m", marks.toggle, { desc = "Marks: Toggle on current line" })
        vim.keymap.set("n", "<leader>vx", marks.delete_buf, { desc = "Marks: Delete all marks in buffer" })
        vim.keymap.set("n", "<leader>vX", "<cmd>delmarks A-Z<CR>", { desc = "Marks: Delete all global marks" })
    end,
})
