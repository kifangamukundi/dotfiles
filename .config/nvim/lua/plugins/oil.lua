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
            default_file_explorer = false,
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

        -- New file        %       Prompt for name in current directory
        -- New directory   d       Prompt for name in current directory
        -- Rename           R       Prompt for new name (cursor on item)
        -- Delete           D       Confirm before deletion
        -- Mark file        mf      Mark file(s) for copy/move (adds a *)
        -- Unmark all       mu      Unmark all marked files
        -- Mark target dir  mt      Set destination directory for copy/move
        -- Copy             mc + p  mf file(s) → mt target → mc → navigate to target → p to paste
        -- Move             mm + p  mf file(s) → mt target → mm → navigate to target → p to paste
        vim.keymap.set("n", "<leader>ve", "<cmd>Ex<CR>", { desc = "Open netrw in current buffer" })
        vim.keymap.set("n", "<leader>vE", function() vim.cmd("Ex " .. vim.fn.getcwd()) end,
            { desc = "Open netrw in current working directory" })
    end,
})
