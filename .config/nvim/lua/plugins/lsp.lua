vim.pack.add({
    { src = "https://github.com/mason-org/mason.nvim", name = "mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim", name = "mason-lspconfig.nvim" },
    { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim", name = "mason-tool-installer.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig", name = "nvim-lspconfig" },
})

-- Centralized LSP Attach logic (available immediately)
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kifanga-lsp-attach", { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then return end

        -- Safety check: don't attach LSP to huge files (>1MB) to prevent hanging
        local file_name = vim.api.nvim_buf_get_name(event.buf)
        local ok, stats = pcall(vim.loop.fs_stat, file_name)
        if ok and stats and stats.size > 1048576 then
            vim.notify("File too large, disabling LSP for " .. file_name, vim.log.levels.WARN)
            vim.lsp.buf_detach_client(event.buf, client.id)
            return
        end

        local function supports(method) return client:supports_method(method) end

        -- KEYMAPS (Preserved exactly)
        vim.keymap.set("n", "grD", vim.lsp.buf.declaration, { buffer = event.buf, desc = "LSP: Go to Declaration" })
        vim.keymap.set({ "n", "v" }, "gd", vim.lsp.buf.definition, { buffer = event.buf, desc = "LSP: Go to Definition" })
        vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, { buffer = event.buf, desc = "LSP: Go to Type Definition" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf, desc = "LSP: Hover Documentation" })
        vim.keymap.set("n", "gri", vim.lsp.buf.implementation, { buffer = event.buf, desc = "LSP: Go to Implementation" })
        vim.keymap.set({ "i", "n" }, "<C-s>", vim.lsp.buf.signature_help, { buffer = event.buf, desc = "LSP: Signature Help" })
        vim.keymap.set("n", "grn", vim.lsp.buf.rename, { buffer = event.buf, desc = "LSP: Rename" })

        if supports(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup("kifanga-lsp-highlight-" .. event.buf, { clear = true })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("kifanga-lsp-detach-" .. event.buf, { clear = true }),
                callback = function(event2)
                    if event2.buf == event.buf then
                        vim.lsp.buf.clear_references()
                        vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = event.buf })
                    end
                end,
            })
        end

        if supports(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.keymap.set("n", "<leader>vH", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, { buffer = event.buf, desc = "LSP: toggle Inlay hints" })
        end
    end,
})

-- Centralized Auto-format on Save
vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("kifanga-lsp-format", { clear = true }),
    callback = function(args)
        -- Prefer null-ls for formatting if it's available for the current buffer
        local clients = vim.lsp.get_clients({ bufnr = args.buf })
        local has_null_ls = false
        for _, client in ipairs(clients) do
            if client.name == "null-ls" then
                has_null_ls = true
                break
            end
        end

        vim.lsp.buf.format({
            bufnr = args.buf,
            async = false, -- Still false to ensure it finishes before save, but we've optimized the clients
            filter = function(client)
                if has_null_ls then
                    return client.name == "null-ls"
                end
                return client.name ~= "ts_ls" -- Always skip ts_ls formatting as it can be slow and redundant
            end,
        })
    end,
})

-- Lazy Setup function
local function setup_lsp()
    if _G._lsp_setup_done then return end
    _G._lsp_setup_done = true

    require("mason").setup({})

    local ok, blink = pcall(require, "blink.cmp")
    local capabilities = ok and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()
    local util = require("lspconfig.util")
    local servers = {
        gopls = {
            root_dir = util.root_pattern("go.work", "go.mod"),
        },
        rust_analyzer = {},
        clangd = {},
        pyright = {},
        ts_ls = {
            root_dir = util.root_pattern("package.json", "tsconfig.json"),
            single_file_support = true,
            settings = {
                typescript = {
                    tsserver = {
                        maxTsServerMemory = 4096,
                    },
                },
            },
        },
        lua_ls = { settings = { Lua = { completion = { callSnippet = "Replace" }, diagnostics = { disable = { "missing-fields" } } } } },
        html = {}, cssls = {}, tailwindcss = {}, svelte = {}, marksman = {}, jsonls = {}, bashls = {},
    }

    require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = false,
        automatic_enable = true,
        handlers = {
            function(server_name)
                local server = servers[server_name] or {}
                server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                require("lspconfig")[server_name].setup(server)
            end,
        },
    })

    -- Defer mason-tool-installer to avoid blocking UI during startup
    vim.defer_fn(function()
        require("mason-tool-installer").setup({
            ensure_installed = { "prettierd", "stylua", "goimports", "eslint_d" }
        })
    end, 100)
end

-- Trigger LSP setup on first buffer read
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("kifanga-lsp-lazy-setup", { clear = true }),
    callback = function()
        setup_lsp()
    end,
})

-- Handle cases where Neovim is opened directly with a file
if vim.api.nvim_buf_get_name(0) ~= "" or vim.bo.filetype ~= "" then
    setup_lsp()
end

-- DIAGNOSTICS CONFIG (Lightweight)
vim.diagnostic.config({
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "E ", [vim.diagnostic.severity.WARN] = "W ",
            [vim.diagnostic.severity.INFO] = "I ", [vim.diagnostic.severity.HINT] = "H ",
        },
    },
    virtual_text = { source = "if_many", spacing = 4, prefix = "●" },
})



