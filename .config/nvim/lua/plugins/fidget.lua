vim.pack.add({
    {
        src = "https://github.com/j-hui/fidget.nvim",
        name = "Fidget.nvim",
    },
})

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("kifanga-fidget-setup", { clear = true }),
    once = true,
    callback = function()
        require("fidget").setup({})
    end,
})
