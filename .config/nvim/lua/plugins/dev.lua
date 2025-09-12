vim.pack.add({
    {
        src = "https://github.com/folke/lazydev.nvim",
        name = "lazydev.nvim",
    },
})

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("kifanga-lazydev-setup", { clear = true }),
    pattern = "lua",
    callback = function()
        require("lazydev").setup({
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        })
    end,
})
