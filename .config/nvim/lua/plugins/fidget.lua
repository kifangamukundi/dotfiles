vim.pack.add({
    { src = "https://github.com/j-hui/fidget.nvim", name = "Fidget.nvim" },
})

vim.defer_fn(function()
    require("fidget").setup({})
end, 100)

