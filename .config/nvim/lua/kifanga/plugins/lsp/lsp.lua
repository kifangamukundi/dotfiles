return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "mason-org/mason.nvim",                opts = {} },
        "mason-org/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        "saghen/blink.cmp",

        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kifanga-lsp-attach", { clear = true }),
            callback = function(event)
                -- Trigger path completion
                -- insert-mode: CTRL-X CTRL-F

                -- Trigger completion
                -- insert-mode: CTRL-X CTRL-O
                -- Next: CTRL-N
                -- Previous: CTRL-P
                -- Accept: CTRL-Y

                -- Default: unknown but like grD
                vim.keymap.set("n", "grD", vim.lsp.buf.declaration,
                    { buffer = event.buf, desc = "LSP: Go to Declaration" })

                -- CTRL-] or CTRL-w-]: Jump to the definition of the keyword under the cursor.
                -- CTRL-t: Go back from where you came from
                -- custom: gd
                vim.keymap.set({ "n", "v" }, "gd", vim.lsp.buf.definition,
                    { buffer = event.buf, desc = "LSP: Go to Definition" })

                -- - "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
                -- - "gO" is mapped in Normal mode to |vim.lsp.buf.document_symbol()|

                -- Default: grt
                vim.keymap.set("n", "grt", vim.lsp.buf.type_definition,
                    { buffer = event.buf, desc = "LSP: Go to Type Definition" })

                -- Default: K
                vim.keymap.set("n", "K", vim.lsp.buf.hover,
                    { buffer = event.buf, desc = "LSP: Hover Documentation" })

                -- Default: gri
                vim.keymap.set("n", "gri", vim.lsp.buf.implementation,
                    { buffer = event.buf, desc = "LSP: Go to Implementation" })

                -- Default: grr
                -- vim.keymap.set("n", "grr", vim.lsp.buf.references,
                --     { buffer = event.buf, desc = "LSP: Go to References" })

                -- Default: insert-mode: CTRL-S
                -- Default: normal-mode unknown but like <C-s>
                -- custom normal-mode: <C-s>
                vim.keymap.set({ "i", "n" }, "<C-s>", vim.lsp.buf.signature_help,
                    { buffer = event.buf, desc = "LSP: Signature Help" })

                -- Default: grn
                vim.keymap.set("n", "grn", vim.lsp.buf.rename, { buffer = event.buf, desc = "LSP: Rename" })

                -- Default: gra
                -- vim.keymap.set("n", "gra", vim.lsp.buf.code_action,
                --     { buffer = event.buf, desc = "LSP: Code Actions" })

                -- Default: gO
                -- Custom: gD
                -- vim.keymap.set("n", "gD", vim.lsp.buf.document_symbol,
                --     { buffer = event.buf, desc = "LSP: Document Symbols" })

                -- Default: unknown but like gW
                -- vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol,
                --     { buffer = event.buf, desc = "LSP: Workspace Symbols" })

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

                    -- FIX: Use event.buf and event.data.client_id for format on save
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = event.buf,
                        callback = function()
                            -- local client = vim.lsp.get_client_by_id(event.data.client_id)
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
                            -- vim.diagnostic.setloclist({})
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
}
