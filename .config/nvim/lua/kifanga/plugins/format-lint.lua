return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local builtins = null_ls.builtins

		null_ls.setup({
			sources = {
				-- Formatting sources
				builtins.formatting.prettierd.with({
					filetypes = {
						"javascript",
						"typescript",
						"javascriptreact",
						"typescriptreact",
						"css",
						"html",
						"json",
						"yaml",
						"markdown",
						"svelte",
					},
				}),
				builtins.formatting.stylua,
				builtins.formatting.goimports,

				-- Linting sources
				require("none-ls.diagnostics.eslint_d").with({
					filetypes = {
						"javascript",
						"typescript",
						"javascriptreact",
						"typescriptreact",
					},
					prefer_local = "node_modules/.bin",
				}),
			},
			on_attach = function(client, bufnr)
				if client:supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = vim.api.nvim_create_augroup("NullLSSaveFormatting", { clear = true }),
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr, async = true })
						end,
					})
				end
			end,
		})

		vim.keymap.set({ "n" }, "<leader>F", function()
			vim.lsp.buf.format({ async = true })
		end, { desc = "Format file or range (using null-ls)" })
	end,
}
