return {
	"chentoast/marks.nvim",
	event = "VimEnter",
	config = function()
		local marks = require("marks")
		local map = vim.keymap.set

		marks.setup({
			default_mappings = false,
			signs = true,
		})

		map("n", "<leader>ma", marks.toggle, { desc = "Marks: Toggle on current line" })
		map("n", "<leader>mn", marks.next, { desc = "Marks: Jump to next mark" })
		map("n", "<leader>mp", marks.prev, { desc = "Marks: Jump to previous mark" })
		map("n", "<leader>mc", marks.delete_buf, { desc = "Marks: Delete all marks in buffer" })
		map("n", "<leader>mo", "<cmd>MarksListBuf<CR>", { desc = "Marks: List all marks in buffer" })
		map("n", "<leader>mO", "<cmd>MarksListGlobal<CR>", { desc = "Marks: List all global marks" })
		map("n", "<leader>mC", "<cmd>delmarks A-Z<CR>", { desc = "Marks: Delete all global marks" })
	end,
}
