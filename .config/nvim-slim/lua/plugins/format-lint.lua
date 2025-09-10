vim.pack.add({
    {
        src = "https://github.com/nvimtools/none-ls-extras.nvim",
        name = "none-ls-extras.nvim",
    },
    {
        src = "https://github.com/nvimtools/none-ls.nvim",
        name = "none-ls.nvim",
    },
})

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("kifanga-null-ls-setup", { clear = true }),
    callback = function()
        local null_ls = require("null-ls")
        local builtins = null_ls.builtins

        null_ls.setup({
            sources = {
                -- Formatting sources
                builtins.formatting.prettierd.with({
                    filetypes = {
                        "javascript",
                        "typescript",
                        "javascriptreact",
                        "typescriptreact",
                        "css",
                        "html",
                        "json",
                        "yaml",
                        "markdown",
                        "svelte",
                    },
                }),
                builtins.formatting.stylua,
                builtins.formatting.goimports,

                -- Linting sources
                require("none-ls.diagnostics.eslint_d").with({
                    filetypes = {
                        "javascript",
                        "typescript",
                        "javascriptreact",
                        "typescriptreact",
                    },
                    prefer_local = "node_modules/.bin",
                }),
            },
        })
    end,
})
