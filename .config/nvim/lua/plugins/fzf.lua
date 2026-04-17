vim.pack.add({
    {
        src = "https://github.com/ibhagwan/fzf-lua",
        name = "fzf-lua",
    },
})

-- Load-on-demand wrapper
local function fzf_call(fn_name, ...)
    local fzf = require("fzf-lua")
    if not _G._fzf_lua_setup_done then
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
                fzf = { ["ctrl-q"] = "select-all+accept" },
                builtin = { ["<C-u>"] = "preview-page-up", ["<C-d>"] = "preview-page-down" },
            },
        })
        fzf.register_ui_select()
        _G._fzf_lua_setup_done = true
    end
    if type(fzf[fn_name]) == "function" then
        fzf[fn_name](...)
    end
end

-- KEYMAPS (Lazy-loading versions)
vim.keymap.set("n", "<leader>f", function() fzf_call("files") end, { desc = "Find Files" })
vim.keymap.set("n", "<C-p>", function() fzf_call("git_files") end, { desc = "Find Git Files" })
vim.keymap.set("n", "<C-g>", function() fzf_call("grep") end, { desc = "Find Grep" })
vim.keymap.set("n", "<leader>w", function() fzf_call("grep_cword") end, { desc = "Search for word under cursor" })
vim.keymap.set("n", "<leader>W", function() fzf_call("grep_cWORD") end, { desc = "Search for WORD under cursor" })
vim.keymap.set("v", "<leader>v", function() fzf_call("grep_visual") end, { desc = "Grep visual" })
vim.keymap.set("n", "<leader>h", function() fzf_call("help_tags") end, { desc = "Help Tags" })

vim.keymap.set("n", "<leader>vb", function() fzf_call("buffers") end, { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>vm", function() fzf_call("marks") end, { desc = "Marks" })
vim.keymap.set("n", "<leader>vr", function() fzf_call("registers") end, { desc = "Registers" })
vim.keymap.set("n", "<leader>vj", function() fzf_call("jumps") end, { desc = "Jumps" })
vim.keymap.set("n", "<leader>vc", function() fzf_call("commands") end, { desc = "Commands" })
vim.keymap.set("n", "<leader>vp", function() fzf_call("manpages") end, { desc = "Man pages" })

-- LSP integration (also lazy)
vim.keymap.set("n", "grd", function() fzf_call("diagnostics_document") end, { desc = "Document Diagnostics" })
vim.keymap.set("n", "grw", function() fzf_call("diagnostics_workspace") end, { desc = "Workspace Diagnostics" })
vim.keymap.set("n", "gra", function() fzf_call("lsp_code_actions") end, { desc = "LSP Code Actions" })
vim.keymap.set("n", "gD", function() fzf_call("lsp_document_symbols") end, { desc = "LSP Document Symbols" })
vim.keymap.set("n", "gW", function() fzf_call("lsp_workspace_symbols") end, { desc = "LSP Workspace Symbols" })
vim.keymap.set("n", "grr", function() fzf_call("lsp_references") end, { desc = "LSP References" })

