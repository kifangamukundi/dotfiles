return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local oil = require("oil")

		oil.setup({
			use_default_keymaps = false,
			columns = {
				"icon",
			},
			keymaps = {
				["<CR>"] = "actions.select",
				["."] = "actions.toggle_hidden",
				["-"] = "actions.parent",
				["q"] = "actions.close",
				["<Esc>"] = "actions.close",
			},
			view_options = {
				show_hidden = true,
			},
		})

		local map = vim.keymap.set

		map("n", "<leader>e", oil.open, { desc = "Open Oil in current directory" })
		map("n", "<leader>E", function()
			oil.open(".")
		end, { desc = "Open Oil in current working directory" })
	end,
}
