vim.pack.add({
    {
        src = "https://github.com/lukas-reineke/indent-blankline.nvim",
        name = "indent-blankline.nvim",
    },
})

vim.api.nvim_create_autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup("kifanga-indent-blankline-setup", { clear = true }),
    callback = function()
        require("ibl").setup({
            indent = {
                char = "│",
            },
            scope = {
                enabled = false,
            },
        })
    end,
})
