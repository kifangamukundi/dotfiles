vim.pack.add({
    { src = "https://github.com/stevearc/oil.nvim", name = "oil.nvim" },
})

-- Load-on-demand wrapper
local function oil_call(fn_name, ...)
    local oil = require("oil")
    if not _G._oil_setup_done then
        oil.setup({
            use_default_keymaps = false,
            default_file_explorer = false,
            columns = {},
            keymaps = {
                ["<CR>"] = "actions.select", ["."] = "actions.toggle_hidden", ["-"] = "actions.parent",
                ["q"] = "actions.close", ["<Esc>"] = "actions.close",
            },
            view_options = { show_hidden = true },
        })
        _G._oil_setup_done = true
    end
    if type(oil[fn_name]) == "function" then
        oil[fn_name](...)
    elseif fn_name == "open_cwd" then
        oil.open(".")
    end
end

-- KEYMAPS (Lazy versions)
vim.keymap.set("n", "<leader>e", function() oil_call("open") end, { desc = "Open Oil in current directory" })
vim.keymap.set("n", "<leader>E", function() oil_call("open_cwd") end, { desc = "Open Oil in cwd" })

-- netrw fallback (keep for safety)
vim.keymap.set("n", "<leader>ve", "<cmd>Ex<CR>", { desc = "Open netrw in current buffer" })
vim.keymap.set("n", "<leader>vE", function() vim.cmd("Ex " .. vim.fn.getcwd()) end, { desc = "Open netrw in cwd" })

