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

local ok, null_ls = pcall(require, "null-ls")
if not ok then return end

local builtins = null_ls.builtins

null_ls.setup({
    sources = {
        -- Formatting sources
        builtins.formatting.stylua,
        builtins.formatting.goimports,

        -- Linting sources
        -- Biome provides both formatting and linting via its dedicated LSP!
    },
})

