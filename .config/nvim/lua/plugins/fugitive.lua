vim.pack.add({
    {
        src = "https://github.com/tpope/vim-fugitive",
        name = "vim-fugitive",
    },
})

vim.keymap.set("n", "<leader>g", "<cmd>:0Git<CR>", { desc = "Git status" })
vim.keymap.set("n", "<leader>vd", function()
    local rev = vim.fn.input("Diff against revision (e.g., HEAD~1 or !~1): ")
    if rev ~= "" then
        vim.cmd("Gvdiffsplit " .. rev)
    end
end, { desc = "Git diff against revision" })
vim.keymap.set("n", "<leader>vl", "<cmd>:0Git log --oneline --graph --decorate --parents<CR>",
    { desc = "Git log" })
vim.keymap.set("n", "<leader>vo", "<cmd>diffget //2<CR>", { desc = "Keep ours OR (2X on fugitive)" })
vim.keymap.set("n", "<leader>vt", "<cmd>diffget //3<CR>", { desc = "Keep Theirs OR (3X on fugitive)" })

local fugitive_augroup = vim.api.nvim_create_augroup("Fugitive", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = fugitive_augroup,
    pattern = "fugitive://*",
    callback = function()
        -- Set bufhidden for fugitive buffers
        vim.opt_local.bufhidden = "delete"
        vim.keymap.set("n", "<leader>p", ":Git push<CR>", { buffer = true, desc = "Git push" })
        vim.keymap.set("n", "<leader>u", function()
            local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]
            if branch == "main" then
                vim.cmd(":Git pull --ff-only")
            else
                vim.cmd(":Git pull --rebase origin main")
            end
        end, { buffer = true, desc = "Smart Git pull" })
    end,
})
