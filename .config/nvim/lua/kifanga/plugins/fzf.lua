return {
    "ibhagwan/fzf-lua",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local fzf = require("fzf-lua")

        fzf.setup({
            winopts = {
                height = 0.85,
                width = 0.80,
                row = 0.35,
                col = 0.50,
                border = "rounded",
            },
            previewer = {
                layout = "vertical",
                vertical = "up:45%",
            },
            files = {
                prompt = "Files❯ ",
                fd_opts = "--color=never --type f --hidden --follow --exclude .git",
            },
            live_grep = {
                prompt = "Live Grep❯ ",
                rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case",
                file_opts = "--iglob '!{.git,node_modules}/*'",
            },
            buffers = { prompt = "Buffers❯ " },
            help_tags = { prompt = "Help❯ " },
            marks = { prompt = "Marks❯ " },
            keymap = {
                fzf = {
                    ["ctrl-q"] = "select-all+accept",
                },
                builtin = {
                    ["<C-u>"] = "preview-page-up",
                    ["<C-d>"] = "preview-page-down",
                },
            },
        })

        -- Register fzf-lua as UI backend for vim.ui.select
        fzf.register_ui_select()

        vim.keymap.set("n", "<leader>f", fzf.files, { desc = "Find Files" })
        vim.keymap.set("n", "<C-p>", fzf.git_files, { desc = "Find Git Files" })
        vim.keymap.set("n", "<leader>k", fzf.grep, { desc = "Find Grep" })
        vim.keymap.set("n", "<leader>vw", fzf.grep_cword, { desc = "Search for word under cursor" })
        vim.keymap.set("n", "<leader>vW", fzf.grep_cWORD, { desc = "Search for WORD under cursor" })

        vim.keymap.set("n", "<leader>vh", fzf.help_tags, { desc = "Help Tags" })
        vim.keymap.set("n", "<leader>vb", fzf.buffers, { desc = "Find Buffers" })
        vim.keymap.set("n", "<leader>vm", fzf.marks, { desc = "Marks" })
        vim.keymap.set("n", "<leader>vr", fzf.registers, { desc = "Registers" })
        vim.keymap.set("n", "<leader>vj", fzf.jumps, { desc = "Jumps" })
        vim.keymap.set("n", "<leader>vk", fzf.keymaps, { desc = "Keymaps" })
        vim.keymap.set("n", "<leader>vc", fzf.commands, { desc = "Commands" })
        vim.keymap.set("n", "<leader>vp", fzf.manpages, { desc = "Man pages" })

        -- Default: unknown but like grd
        vim.keymap.set("n", "grd", fzf.diagnostics_document, { desc = "Document Diagnostics" })

        -- Default: unknown but like grw
        vim.keymap.set("n", "grw", fzf.diagnostics_workspace, { desc = "Workspace Diagnostics" })

        -- Default: gra
        vim.keymap.set("n", "gra", fzf.lsp_code_actions, { desc = "LSP Code Actions" })

        -- Default: gO
        -- Default: gD
        vim.keymap.set("n", "gD", fzf.lsp_document_symbols, { desc = "LSP Document Symbols" })

        -- Default: unknown but like gW
        vim.keymap.set("n", "gW", fzf.lsp_workspace_symbols, { desc = "LSP Workspace Symbols" })

        -- Default: grr
        vim.keymap.set("n", "grr", fzf.lsp_references, { desc = "LSP References" })
    end,
}
