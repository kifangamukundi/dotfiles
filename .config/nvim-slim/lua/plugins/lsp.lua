vim.pack.add({
    {
        src = "https://github.com/neovim/nvim-lspconfig",
        name = "nvim-lspconfig",
    },
    {
        src = "https://github.com/mason-org/mason.nvim",
        name = "mason.nvim",
    },
    {
        src = "https://github.com/mason-org/mason-lspconfig.nvim",
        name = "mason-lspconfig.nvim",
    },
    {
        src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
        name = "mason-tool-installer.nvim",
    },
    {
        src = "https://github.com/saghen/blink.cmp",
        name = "blink.cmp",
        version = 'v1.6.0'
    },
    {
        src = "https://github.com/antosha417/nvim-lsp-file-operations",
        name = "nvim-lsp-file-operations",
        config = true
    },
})

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("kifanga-lsp-setup", { clear = true }),
    callback = function()
        require("mason").setup({})

        -- require("nvim-lsp-file-operations").setup()

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kifanga-lsp-attach", { clear = true }),
            callback = function(event)
                vim.keymap.set("n", "grD", vim.lsp.buf.declaration,
                    { buffer = event.buf, desc = "LSP: Go to Declaration" })

                vim.keymap.set({ "n", "v" }, "gd", vim.lsp.buf.definition,
                    { buffer = event.buf, desc = "LSP: Go to Definition" })

                vim.keymap.set("n", "grt", vim.lsp.buf.type_definition,
                    { buffer = event.buf, desc = "LSP: Go to Type Definition" })

                vim.keymap.set("n", "K", vim.lsp.buf.hover,
                    { buffer = event.buf, desc = "LSP: Hover Documentation" })

                vim.keymap.set("n", "gri", vim.lsp.buf.implementation,
                    { buffer = event.buf, desc = "LSP: Go to Implementation" })

                vim.keymap.set({ "i", "n" }, "<C-s>", vim.lsp.buf.signature_help,
                    { buffer = event.buf, desc = "LSP: Signature Help" })

                vim.keymap.set("n", "grn", vim.lsp.buf.rename, { buffer = event.buf, desc = "LSP: Rename" })

                local function client_supports_method(client, method, bufnr)
                    return client:supports_method(method, bufnr)
                end

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if
                    client
                    and client.supports_method(
                        client,
                        vim.lsp.protocol.Methods.textDocument_documentHighlight,
                        event.buf
                    )
                then
                    local highlight_augroup = vim.api.nvim_create_augroup("kifanga-lsp-highlight", { clear = false })
                    -- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                    --     buffer = event.buf,
                    --     group = highlight_augroup,
                    --     callback = vim.lsp.buf.document_highlight,
                    -- })
                    --
                    -- vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                    --     buffer = event.buf,
                    --     group = highlight_augroup,
                    --     callback = vim.lsp.buf.clear_references,
                    -- })

                    local diag_augroup = vim.api.nvim_create_augroup("kifanga-lsp-diags", { clear = false })

                    vim.api.nvim_create_autocmd("DiagnosticChanged", {
                        buffer = event.buf,
                        group = diag_augroup,
                        callback = function()
                            if not vim.g.quitting then
                                vim.diagnostic.setloclist({ open = false })
                                vim.diagnostic.setqflist({ open = false })
                            end
                        end,
                    })

                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = event.buf,
                        callback = function()
                            if client and client.server_capabilities.documentFormattingProvider then
                                vim.lsp.buf.format({
                                    bufnr = event.buf,
                                    id = client.id,
                                    async = true,
                                })
                            end
                        end,
                    })

                    vim.api.nvim_create_autocmd("QuitPre", {
                        buffer = event.buf,
                        group = diag_augroup,
                        callback = function()
                            vim.g.quitting = true
                        end,
                    })

                    vim.api.nvim_create_autocmd("LspDetach", {
                        group = vim.api.nvim_create_augroup("kifanga-lsp-detach", { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = event2.buf })
                        end,
                    })
                end

                if
                    client
                    and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
                then
                    vim.keymap.set("n", "<leader>vH", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                    end, { buffer = event.buf, desc = "LSP: toggle Inlay hints" })
                end
            end,
        })

        vim.diagnostic.config({
            severity_sort = true,
            float = { border = "rounded", source = "if_many" },
            underline = { severity = vim.diagnostic.severity.ERROR },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "E ",
                    [vim.diagnostic.severity.WARN] = "W ",
                    [vim.diagnostic.severity.INFO] = "I ",
                    [vim.diagnostic.severity.HINT] = "H ",
                },
            },
            virtual_text = {
                source = "if_many",
                spacing = 2,
                format = function(diagnostic)
                    local diagnostic_message = {
                        [vim.diagnostic.severity.ERROR] = diagnostic.message,
                        [vim.diagnostic.severity.WARN] = diagnostic.message,
                        [vim.diagnostic.severity.INFO] = diagnostic.message,
                        [vim.diagnostic.severity.HINT] = diagnostic.message,
                    }
                    return diagnostic_message[diagnostic.severity]
                end,
            },
        })

        local capabilities = require("blink.cmp").get_lsp_capabilities()

        local servers = {
            gopls = {},
            rust_analyzer = {},
            clangd = {},
            pyright = {},
            ts_ls = {},
            lua_ls = {},
            html = {},
            cssls = {},
            tailwindcss = {},
            svelte = {},
            marksman = {},
            jsonls = {},
            bashls = {},
        }

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            "prettierd",
            "stylua",
            "goimports",
            "eslint_d",
        })
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        require("mason-lspconfig").setup({
            ensure_installed = {},
            automatic_installation = false,
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })
    end,
})
