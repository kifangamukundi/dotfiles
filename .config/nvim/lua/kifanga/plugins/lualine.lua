return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require("lualine")

        local function get_mode()
            local mode = vim.api.nvim_get_mode().mode

            local custom_mode_map = {
                ["n"] = "Chillin",
                ["no"] = "Noble",
                ["nov"] = "Noble (Visual)",
                ["noV"] = "Noble (V-Line)",
                ["no\22"] = "Noble (V-Block)",

                ["niI"] = "Chillin (Insert)",
                ["niR"] = "Chillin (Replace)",
                ["niV"] = "Chillin (Virtual)",

                ["v"] = "Selecting",
                ["V"] = "Selecting (Line)",
                ["\22"] = "Selecting (Block)",

                ["s"] = "Select Mode",
                ["S"] = "Select Line",
                ["R"] = "Overwriting",
                ["Rv"] = "Virtual Replace",
                ["r"] = "Replacing",
                ["rm"] = "Replacing More",
                ["r?"] = "Replacing Confirm",

                ["i"] = "Typing",
                ["ic"] = "Typing (Completion)",
                ["ix"] = "Typing (Unknown)",

                ["c"] = "Commanding",
                ["cv"] = "Ex Mode",
                ["ce"] = "Ex Confirm",

                ["o"] = "Operator",
                ["x"] = "Exiting",

                ["t"] = "Terminal",
                ["!"] = "Shell",
            }
            return " " .. (custom_mode_map[mode] or ("[" .. mode .. "]")) .. " "
        end

        local function lsp_clients()
            local get_lsp_clients = vim.lsp.get_clients
            local clients = get_lsp_clients({ bufnr = vim.api.nvim_get_current_buf() })

            if #clients > 0 then
                local names = vim.tbl_map(function(client)
                    return client.name
                end, clients)
                return ": " .. table.concat(names, ", ")
            else
                return ""
            end
        end

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
            replace = {
                a = { fg = "#f7768e", gui = "bold" },
                b = { fg = "#f7768e", gui = "bold" },
                c = { fg = "#f7768e", gui = "bold" },
            },
            command = {
                a = { fg = "#e0af68", gui = "bold" },
                b = { fg = "#e0af68", gui = "bold" },
                c = { fg = "#e0af68", gui = "bold" },
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
                component_separators = { left = ">", right = "<" },
                section_separators = { left = ">", right = "<" },
            },
            sections = {
                lualine_a = { get_mode },
                lualine_b = { "filename" },
                lualine_c = { "diagnostics", lsp_clients, "branch" },
                lualine_x = { "filetype" },
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
            extensions = {},
        })
    end,
}
