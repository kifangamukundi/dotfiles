vim.pack.add({
    {
        src = "https://github.com/folke/which-key.nvim",
        name = "which-key.nvim",
    },
})

vim.opt.timeout = true

require("which-key").setup({
    preset = "helix",
})

