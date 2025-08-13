return {
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = false,
	priority = 1000,
	config = function()
		require("rose-pine").setup({
			variant = "moon", -- 'main', 'moon', or 'dawn'
			styles = {
				transparency = true,
			},
			disable_background = true,
		})
		vim.cmd("colorscheme rose-pine")
	end,
}
