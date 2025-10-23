vim.api.nvim_create_user_command("PackUpdateAll", function()
    vim.schedule(function()
        local ok, err = pcall(vim.pack.update)
        if not ok then
            vim.notify("Pack update failed: " .. err, vim.log.levels.ERROR)
        else
            vim.notify("All plugins updated!", vim.log.levels.INFO)
        end
    end)
end, { desc = "Update all plugins" })

vim.api.nvim_create_autocmd("TextYankPost",
    {
        desc = "Highlight when yanking (copying) text",
        group = vim.api.nvim_create_augroup("kifanga-highlight-yank",
            { clear = true }),
        callback = function() vim.hl.on_yank() end,
    })
