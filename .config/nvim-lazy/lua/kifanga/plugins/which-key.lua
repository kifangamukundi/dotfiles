return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.opt.timeout = true
	end,
	config = function()
		require("which-key").setup({
			preset = "helix",
		})
	end,
}
