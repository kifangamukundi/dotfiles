return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        local map = vim.keymap.set

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

        map("n", "<leader>a", function()
            harpoon:list():add()
        end, { desc = "Harpoon: Add file" })

        -- map("n", "<leader>hc", function()
        -- 	harpoon:list():clear()
        -- end, { desc = "Harpoon: Clear list" })

        map("n", "<leader>h", function()
            harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts)
        end, { desc = "Harpoon: Open menu" })

        -- map("n", "<leader>hn", function()
        -- 	harpoon:list():next()
        -- end, { desc = "Harpoon: Next file" })
        -- map("n", "<leader>hp", function()
        -- 	harpoon:list():prev()
        -- end, { desc = "Harpoon: Previous file" })

        for i = 1, 9 do
            map("n", "<leader>" .. i, function()
                harpoon:list():select(i)
            end, { desc = "Harpoon: Select file " .. i })
        end
    end,
}
