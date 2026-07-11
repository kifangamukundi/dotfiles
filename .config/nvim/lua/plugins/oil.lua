vim.pack.add({
    { src = "https://github.com/stevearc/oil.nvim", name = "oil.nvim" },
})

-- Workaround for Neovim 0.12/0.13 filetype matching overriding oil buffers to 'directory'
vim.api.nvim_create_autocmd("FileType", {
    pattern = "directory",
    callback = function()
        if vim.api.nvim_buf_get_name(0):match("^oil://") then
            vim.bo.filetype = "oil"
        end
    end,
})
local oil = require("oil")
oil.setup({
    use_default_keymaps = false,
    default_file_explorer = true,
    columns = {},
    keymaps = {
        ["<CR>"] = "actions.select", ["."] = "actions.toggle_hidden", ["-"] = "actions.parent",
        ["q"] = "actions.close", ["<Esc>"] = "actions.close",
    },
    view_options = { show_hidden = true },
})

-- KEYMAPS
vim.keymap.set("n", "<leader>e", function() oil.open() end, { desc = "Open Oil in current directory" })
vim.keymap.set("n", "<leader>E", function() oil.open(".") end, { desc = "Open Oil in cwd" })
