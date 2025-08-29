return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require("lualine")

        local custom_theme = {
            normal = {
                a = { fg = "#3e8fb0", gui = "bold" },
                b = { fg = "#3e8fb0", gui = "bold" },
                c = { fg = "#3e8fb0", gui = "bold" },
            },
            insert = {
                a = { fg = "#95b1ac", gui = "bold" },
                b = { fg = "#95b1ac", gui = "bold" },
                c = { fg = "#95b1ac", gui = "bold" },
            },
            visual = {
                a = { fg = "#c4a7e7", gui = "bold" },
                b = { fg = "#c4a7e7", gui = "bold" },
                c = { fg = "#c4a7e7", gui = "bold" },
            },
            command = {
                a = { fg = "#f6c177", gui = "bold" },
                b = { fg = "#f6c177", gui = "bold" },
                c = { fg = "#f6c177", gui = "bold" },
            },
            replace = {
                a = { fg = "#eb6f92", gui = "bold" },
                b = { fg = "#eb6f92", gui = "bold" },
                c = { fg = "#eb6f92", gui = "bold" },
            },
            inactive = {
                a = { fg = "#6e6a86", gui = "bold" },
                b = { fg = "#6e6a86", gui = "bold" },
                c = { fg = "#6e6a86", gui = "bold" },
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
