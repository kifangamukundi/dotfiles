vim.pack.add({
    {
        src = "https://github.com/stevearc/oil.nvim",
        name = "oil.nvim",
    },
})

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local oil = require("oil")

        oil.setup({
            use_default_keymaps = false,
            columns = {
                -- "icon",
            },
            keymaps = {
                ["<CR>"] = "actions.select",
                ["."] = "actions.toggle_hidden",
                ["-"] = "actions.parent",
                ["q"] = "actions.close",
                ["<Esc>"] = "actions.close",
            },
            view_options = {
                show_hidden = true,
            },
        })

        vim.keymap.set("n", "<leader>e", oil.open, { desc = "Open Oil in current directory" })
        vim.keymap.set("n", "<leader>E", function()
            oil.open(".")
        end, { desc = "Open Oil in current working directory" })
    end,
})
