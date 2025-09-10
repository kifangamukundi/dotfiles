vim.pack.add({
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        name = "nvim-treesitter",
    },
    {
        src = "https://github.com/windwp/nvim-ts-autotag",
        name = "nvim-ts-autotag",
    },
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
        name = "nvim-treesitter-textobjects",
    },
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("kifanga-treesitter-setup", { clear = true }),
    callback = function()
        local treesitter = require("nvim-treesitter.configs")

        treesitter.setup({
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "json",
                "javascript",
                "typescript",
                "tsx",
                "yaml",
                "html",
                "css",
                "svelte",
                "markdown",
                "markdown_inline",
                "bash",
                "gitignore",
                "go",
            },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            autotag = { enable = true },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    node_incremental = "<C-n>",
                    node_decremental = "<C-p>",
                    scope_incremental = false,
                },
            },
            additional_vim_regex_highlighting = false,

            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",

                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",

                        ["ac"] = "@comment.outer",
                        ["ic"] = "@comment.inner",

                        ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                    },
                    selection_modes = {
                        ["@parameter.outer"] = "v",
                        ["@function.outer"] = "V",
                        ["@class.outer"] = "<c-v>",
                    },
                    include_surrounding_whitespace = true,
                },
            },
        })
    end,
})

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("kifanga-treesitter-update", { clear = true }),
    once = true,
    callback = function()
        vim.cmd("TSUpdate")
    end,
})
