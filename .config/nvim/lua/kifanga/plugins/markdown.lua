return {
    -- 1. vim-markdown: Syntax highlighting and folding
    {
        "plasticboy/vim-markdown",
        ft = { "markdown" },
        config = function()
            vim.g.vim_markdown_folding_disabled = 1
            vim.g.vim_markdown_conceal = 0
            vim.g.vim_markdown_strikethrough = 1
        end,
    },

    -- 2. markdown-preview.nvim: Live preview in your browser
    {
        "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        config = function()
            vim.g.mkdp_filetypes = { "markdown" }

            local map = vim.keymap.set
            map("n", "<leader>mp", "<Cmd>MarkdownPreviewToggle<CR>", {
                desc = "Toggle Markdown Preview",
                buffer = true,
            })
        end,
    },

    -- 3. vim-pencil: Simple and focused markdown editing
    {
        "preservim/vim-pencil",
        ft = { "markdown" },
        config = function()
            vim.cmd("PencilSoft")
        end,
    },
}
