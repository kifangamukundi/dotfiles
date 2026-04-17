vim.pack.add({
    { src = "https://github.com/folke/which-key.nvim", name = "which-key.nvim" },
})

vim.opt.timeout = true

vim.defer_fn(function()
    require("which-key").setup({ preset = "helix" })
end, 200)

