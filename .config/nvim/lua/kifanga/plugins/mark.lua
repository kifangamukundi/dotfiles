return {
    "chentoast/marks.nvim",
    event = "VimEnter",
    config = function()
        local marks = require("marks")

        marks.setup({
            default_mappings = false,
            signs = true,
        })

        vim.keymap.set("n", "<leader>m", marks.toggle, { desc = "Marks: Toggle on current line" })
        vim.keymap.set("n", "<leader>vx", marks.delete_buf, { desc = "Marks: Delete all marks in buffer" })
        vim.keymap.set("n", "<leader>vX", "<cmd>delmarks A-Z<CR>", { desc = "Marks: Delete all global marks" })
    end,
}
