vim.pack.add({
    {
        src = "https://github.com/mbbill/undotree",
        name = "undotree",
    },
})

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("kifanga-undotree-setup", { clear = true }),
    callback = function()
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
    end,
})
