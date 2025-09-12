vim.pack.add({
    {
        src = "https://github.com/folke/which-key.nvim",
        name = "which-key.nvim",
    },
})

vim.opt.timeout = true

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("kifanga-which-key-setup", { clear = true }),
    callback = function()
        require("which-key").setup({
            preset = "helix",
        })
    end,
})
