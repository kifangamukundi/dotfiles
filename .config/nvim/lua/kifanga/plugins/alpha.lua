return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = { "Welcome, Kifanga Mukundi" }

        dashboard.section.buttons.val = {
            dashboard.button("<leader>r", "Restore Session", ":SessionRestore <CR>"),
        }

        alpha.setup(dashboard.opts)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "alpha",
            callback = function()
                vim.opt_local.foldenable = false
            end,
        })
    end,
}
