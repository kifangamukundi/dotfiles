return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
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
}
