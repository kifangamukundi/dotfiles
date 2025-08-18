function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

	vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#51B3EC", bold = true })
	vim.api.nvim_set_hl(0, "LineNr", { fg = "white", bold = true })
	vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#FB508F", bold = true })

	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#212121" })
	vim.api.nvim_set_hl(0, "Visual", { bg = "#3c3c3c" })

	vim.api.nvim_set_hl(0, "Search", { bg = "#3c3c3c", fg = "#ffffff", bold = true })
	vim.api.nvim_set_hl(0, "IncSearch", { bg = "#5f5faf", fg = "#ffffff", bold = true })
	vim.api.nvim_set_hl(0, "MatchParen", { bg = "#444444", fg = "#ffffff", bold = true })
end

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
		ColorMyPencils()
	end,
}
