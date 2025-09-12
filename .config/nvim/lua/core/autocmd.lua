vim.api.nvim_create_user_command("PackUpdateAll", function()
    vim.pack.update()
    vim.notify("All plugins updated!", vim.log.levels.INFO)
end, { desc = "Update all plugins" })

vim.api.nvim_create_autocmd("TextYankPost",
    {
        desc = "Highlight when yanking (copying) text",
        group = vim.api.nvim_create_augroup("kifanga-highlight-yank",
            { clear = true }),
        callback = function() vim.hl.on_yank() end,
    })
