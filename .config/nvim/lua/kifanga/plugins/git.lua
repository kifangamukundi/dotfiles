return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufReadPost", "BufWritePost" },
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "..." },
                },
                current_line_blame = true,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol",
                    delay = 1000,
                },
                linehl = false,
            })
        end,
    },
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>g", "<cmd>:0Git<CR>", { desc = "Git status" })
            vim.keymap.set("n", "<leader>vl", "<cmd>:0Gclog<CR>", { desc = "Git log" })
            vim.keymap.set("n", "<leader>vo", "<cmd>diffget //2<CR>", { desc = "Keep ours OR (2X on fugitive)" })
            vim.keymap.set("n", "<leader>vt", "<cmd>diffget //3<CR>", { desc = "Keep Theirs OR (3X on fugitive)" })

            local fugitive_augroup = vim.api.nvim_create_augroup("Fugitive", { clear = true })

            vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
                group = fugitive_augroup,
                pattern = "fugitive://*",
                callback = function()
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
        end,
    },
}
