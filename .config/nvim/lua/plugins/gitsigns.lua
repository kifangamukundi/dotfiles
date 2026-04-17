vim.pack.add({
    {
        src = "https://github.com/lewis6991/gitsigns.nvim",
        name = "gitsigns.nvim",
    },
})

require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "..." },
    },
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
    },
    linehl = false,
})

