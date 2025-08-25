return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
            },
        })

        local toggle_opts = {
            border = "rounded",
            title_pos = "center",
            ui_width_ratio = 0.60,
        }

        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end, { desc = "Harpoon: Add file" })

        -- vim.keymap.set("n", "<leader>hc", function()
        -- 	harpoon:list():clear()
        -- end, { desc = "Harpoon: Clear list" })

        vim.keymap.set("n", "<leader>h", function()
            harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts)
        end, { desc = "Harpoon: Open menu" })

        -- vim.keymap.set("n", "<leader>hn", function()
        -- 	harpoon:list():next()
        -- end, { desc = "Harpoon: Next file" })
        -- vim.keymap.set("n", "<leader>hp", function()
        -- 	harpoon:list():prev()
        -- end, { desc = "Harpoon: Previous file" })

        for i = 1, 5 do
            vim.keymap.set("n", "<leader>" .. i, function()
                harpoon:list():select(i)
            end, { desc = "Harpoon: Select file " .. i })
        end
    end,
}
