vim.pack.add({
    {
        src = "https://github.com/mbbill/undotree",
        name = "undotree",
    },
})

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })

