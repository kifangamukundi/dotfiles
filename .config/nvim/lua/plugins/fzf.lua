vim.pack.add({
    {
        src = "https://github.com/ibhagwan/fzf-lua",
        name = "fzf-lua",
    },
})

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("kifanga-fzf-lua-setup", { clear = true }),
    callback = function()
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

        fzf.register_ui_select()

        vim.keymap.set("n", "<leader>f", fzf.files, { desc = "Find Files" })
        vim.keymap.set("n", "<C-p>", fzf.git_files, { desc = "Find Git Files" })
        vim.keymap.set("n", "<C-g>", fzf.grep, { desc = "Find Grep" })
        vim.keymap.set("n", "<leader>w", fzf.grep_cword, { desc = "Search for word under cursor" })
        vim.keymap.set("n", "<leader>W", fzf.grep_cWORD, { desc = "Search for WORD under cursor" })
        vim.keymap.set("v", "<leader>v", fzf.grep_visual, { desc = "Grep visual" })
        vim.keymap.set("n", "<leader>h", fzf.help_tags, { desc = "Help Tags" })

        vim.keymap.set("n", "<leader>vb", fzf.buffers, { desc = "Find Buffers" })
        vim.keymap.set("n", "<leader>vm", fzf.marks, { desc = "Marks" })
        vim.keymap.set("n", "<leader>vr", fzf.registers, { desc = "Registers" })
        vim.keymap.set("n", "<leader>vj", fzf.jumps, { desc = "Jumps" })
        vim.keymap.set("n", "<leader>vc", fzf.commands, { desc = "Commands" })
        vim.keymap.set("n", "<leader>vp", fzf.manpages, { desc = "Man pages" })

        vim.keymap.set("n", "grd", fzf.diagnostics_document, { desc = "Document Diagnostics" })
        vim.keymap.set("n", "grw", fzf.diagnostics_workspace, { desc = "Workspace Diagnostics" })
        vim.keymap.set("n", "gra", fzf.lsp_code_actions, { desc = "LSP Code Actions" })
        vim.keymap.set("n", "gD", fzf.lsp_document_symbols, { desc = "LSP Document Symbols" })
        vim.keymap.set("n", "gW", fzf.lsp_workspace_symbols, { desc = "LSP Workspace Symbols" })
        vim.keymap.set("n", "grr", fzf.lsp_references, { desc = "LSP References" })
    end,
})
