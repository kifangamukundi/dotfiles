return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require("lualine")

        local custom_theme = {
            normal = {
                a = { fg = "#7aa2f7", gui = "bold" },
                b = { fg = "#7aa2f7", gui = "bold" },
                c = { fg = "#7aa2f7", gui = "bold" },
            },
            insert = {
                a = { fg = "#9ece6a", gui = "bold" },
                b = { fg = "#9ece6a", gui = "bold" },
                c = { fg = "#9ece6a", gui = "bold" },
            },
            visual = {
                a = { fg = "#bb9af7", gui = "bold" },
                b = { fg = "#bb9af7", gui = "bold" },
                c = { fg = "#bb9af7", gui = "bold" },
            },
            command = {
                a = { fg = "#e0af68", gui = "bold" },
                b = { fg = "#e0af68", gui = "bold" },
                c = { fg = "#e0af68", gui = "bold" },
            },
            replace = {
                a = { fg = "#f7768e", gui = "bold" },
                b = { fg = "#f7768e", gui = "bold" },
                c = { fg = "#f7768e", gui = "bold" },
            },
            inactive = {
                a = { fg = "#7f7f7f", gui = "bold" },
                b = { fg = "#7f7f7f", gui = "bold" },
                c = { bg = "#181818", fg = "#7f7f7f", gui = "bold" },
            },
        }

        lualine.setup({
            options = {
                icons_enabled = false,
                theme = custom_theme,
                component_separators = { left = ":", right = ":" },
                section_separators = { left = ":", right = ":" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "filename" },
                lualine_c = {
                    {
                        'lsp_status',
                        ignore_lsp = { 'null-ls' },
                    }
                },
                lualine_x = {
                    {
                        'branch',
                        fmt = string.upper,
                    },
                    "diff", "diagnostics", "searchcount", "selectioncount", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = { "filename" },
                lualine_c = { "diagnostics" },
                lualine_x = { "filetype" },
                lualine_y = {},
                lualine_z = {},
            },
            extensions = { "oil", "fugitive", "quickfix", "fzf" },
        })
    end,
}
