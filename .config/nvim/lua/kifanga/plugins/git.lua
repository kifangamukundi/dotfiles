return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufReadPost" },
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
            local map = vim.keymap.set

            map("n", "<leader>g", "<cmd>:0Git<CR>", { desc = "Git status" })
            -- s Stage (add) the file or hunk under the cursor.
            -- u Unstage (reset) the file or hunk under the cursor.
            -- cc Create a commit.
            -- ca Amend the last commit and edit the message.
            -- ce Amend the last commit without editing the message.
            -- cb<Space> Populate command line with ":Git branch ".
            -- co<Space> Populate command line with ":Git checkout ".
            -- ru: Perform an interactive rebase against @{upstream}.
            -- rp: Perform an interactive rebase against @{push}.
            -- rr Continue the current rebase.
            -- ra Abort the current rebase.
            -- r<Space> Populate command line with ":Git rebase ".
            -- cm<Space> Populate command line with ":Git merge ".

            map("n", "<leader>vl", "<cmd>:0Git log --oneline --graph --decorate --parents<CR>", { desc = "Git log" })

            local fugitive_augroup = vim.api.nvim_create_augroup("Fugitive", { clear = true })

            vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
                group = fugitive_augroup,
                pattern = "fugitive://*",
                callback = function()
                    vim.opt_local.bufhidden = "delete"
                    vim.keymap.set("n", "<leader>vp", ":Git push<CR>", { buffer = true, desc = "Git push" })

                    vim.keymap.set("n", "<leader>vu", function()
                        local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]
                        if branch == "main" then
                            vim.cmd(":Git pull --ff-only")
                        else
                            vim.cmd(":Git pull --rebase origin main")
                        end
                    end, { buffer = true, desc = "Smart Git pull" })

                    -- diff mode = a visual comparison mode for Git changes. Fugitive: dv or dd
                    -- Fugitive: 2X keep ours
                    map("n", "<leader>vo", "<cmd>diffget //2<CR>", { desc = "Keep Ours" })
                    -- Fugitive: 3X keep theirs
                    map("n", "<leader>vt", "<cmd>diffget //3<CR>", { desc = "Keep Theirs" })
                end,
            })
        end,
    },
}
