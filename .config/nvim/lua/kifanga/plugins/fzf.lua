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

        vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find Files" })
        vim.keymap.set("n", "<leader>fg", fzf.git_files, { desc = "Find Git Files" })
        vim.keymap.set("n", "<leader>fl", fzf.live_grep, { desc = "Live Grep" })
        vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Find Buffers" })
        vim.keymap.set("n", "<leader>fd", fzf.diagnostics_document, { desc = "Document Diagnostics" })
        vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "Help Tags" })
        vim.keymap.set("n", "<leader>fm", fzf.marks, { desc = "Marks" })
        vim.keymap.set("n", "<leader>fr", fzf.registers, { desc = "Registers" })
        vim.keymap.set("n", "<leader>fk", fzf.keymaps, { desc = "Keymaps" })
        vim.keymap.set("n", "<leader>fc", fzf.commands, { desc = "Commands" })
        vim.keymap.set("n", "<leader>fp", fzf.manpages, { desc = "Man pages" })
        vim.keymap.set("n", "<leader>fj", fzf.jumps, { desc = "Jumps" })

        -- Default: gra
        vim.keymap.set("n", "gra", fzf.lsp_code_actions, { desc = "LSP Code Actions" })

        -- Default: gO
        vim.keymap.set("n", "gO", fzf.lsp_document_symbols, { desc = "LSP Document Symbols" })

        -- Default: unknown but like gW
        vim.keymap.set("n", "gW", fzf.lsp_workspace_symbols, { desc = "LSP Workspace Symbols" })

        -- Default: grr
        vim.keymap.set("n", "grr", fzf.lsp_references, { desc = "LSP References" })
    end,
}
