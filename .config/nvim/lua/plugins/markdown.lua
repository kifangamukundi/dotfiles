vim.pack.add({
    {
        src = "https://github.com/plasticboy/vim-markdown",
        name = "vim-markdown",
    },
    {
        src = "https://github.com/iamcco/markdown-preview.nvim",
        name = "markdown-preview.nvim",
    },
    {
        src = "https://github.com/preservim/vim-pencil",
        name = "vim-pencil",
    },
})
-- Build command for markdown-preview.nvim (run once on VimEnter)
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("kifanga-markdown-preview-build", { clear = true }),
    once = true,
    callback = function()
        -- Use the plugin's built-in install function
        vim.fn["mkdp#util#install"]()
    end,
})

-- Setup autocmd to configure vim-markdown for markdown files
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("kifanga-vim-markdown-setup", { clear = true }),
    pattern = "markdown",
    callback = function()
        vim.g.vim_markdown_folding_disabled = 1
        vim.g.vim_markdown_conceal = 0
        vim.g.vim_markdown_strikethrough = 1
    end,
})

-- Setup autocmd to configure markdown-preview for markdown files
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("kifanga-markdown-preview-setup", { clear = true }),
    pattern = "markdown",
    callback = function()
        vim.g.mkdp_filetypes = { "markdown" }

        vim.keymap.set("n", "<leader>vp", "<Cmd>MarkdownPreviewToggle<CR>", {
            desc = "Toggle Markdown Preview",
            buffer = true,
        })
    end,
})

-- Setup autocmd to configure vim-pencil for markdown files
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("kifanga-vim-pencil-setup", { clear = true }),
    pattern = "markdown",
    callback = function()
        vim.cmd("PencilSoft")
    end,
})
