vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", name = "nvim-treesitter", version = "master" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", name = "nvim-treesitter-textobjects" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context", name = "nvim-treesitter-context" },
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("kifanga-treesitter-lazy-setup", { clear = true }),
    once = true,
    callback = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "c", "lua", "vim", "vimdoc", "query", "json", "javascript", "typescript", "tsx", "yaml", "html", "css", "svelte", "markdown", "markdown_inline", "bash", "gitignore", "go",
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                disable = { "markdown", "markdown_inline" },
            },
            indent = { enable = true },
            autotag = { enable = false },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = false,
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
                        ["af"] = "@function.outer", ["if"] = "@function.inner",
                        ["al"] = "@loop.outer", ["il"] = "@loop.inner",
                        ["ac"] = "@comment.outer", ["ic"] = "@comment.inner",
                        ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                    },
                    selection_modes = { ["@parameter.outer"] = "v", ["@function.outer"] = "V", ["@class.outer"] = "<c-v>" },
                    include_surrounding_whitespace = true,
                },
            },
        })

        require("treesitter-context").setup({
            enable = true,
            max_lines = 1,
            min_window_height = 0,
            line_numbers = true,
            multiline_threshold = 20,
            trim_scope = "outer",
            mode = "cursor",
            separator = nil,
            zindex = 20,
            on_attach = function(buf)
                -- Disable in markdown due to a known crash in Neovim v0.13.0-dev
                return vim.bo[buf].filetype ~= 'markdown'
            end,
        })

        -- Forcefully stop treesitter for markdown to avoid the runtime crash
        vim.api.nvim_create_autocmd({ "FileType", "BufReadPre" }, {
            group = vim.api.nvim_create_augroup("kifanga-markdown-no-ts", { clear = true }),
            pattern = "markdown",
            callback = function(args)
                pcall(vim.treesitter.stop, args.buf)
            end,
        })
    end,
})

