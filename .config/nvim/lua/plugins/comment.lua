vim.pack.add({
    {
        src = "https://github.com/numToStr/Comment.nvim",
        name = "Comment.nvim",
    },
    {
        src = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
        name = "nvim-ts-context-commentstring",
    },
})

vim.api.nvim_create_autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup("kifanga-comment-setup", { clear = true }),
    callback = function()
        require("ts_context_commentstring").setup()

        require("Comment").setup({
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        })
    end,
})
