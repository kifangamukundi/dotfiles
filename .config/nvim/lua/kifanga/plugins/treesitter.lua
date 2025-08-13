return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")
		local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
		local map = vim.keymap.set

		treesitter.setup({
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"svelte",
				"markdown",
				"markdown_inline",
				"bash",
				"gitignore",
				"go",
			},
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			autotag = { enable = true },

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<C-n>",
					node_decremental = "<C-p>",
					scope_incremental = false,
				},
			},
			additional_vim_regex_highlighting = false,

			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",

						["aL"] = "@loop.outer",
						["iL"] = "@loop.inner",

						["ac"] = "@comment.outer",
						["ic"] = "@comment.inner",

						["aC"] = "@class.outer",
						["iC"] = "@class.inner",

						["ai"] = "@conditional.outer",
						["ii"] = "@conditional.inner",

						["aa"] = "@assignment.outer",
						["ia"] = "@assignment.inner",

						["al"] = "@assignment.lhs",
						["il"] = "@assignment.lhs",

						["ar"] = "@assignment.rhs",
						["ir"] = "@assignment.rhs",
						["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
					},
					selection_modes = {
						["@parameter.outer"] = "v",
						["@function.outer"] = "V",
						["@class.outer"] = "<c-v>",
					},
					include_surrounding_whitespace = true,
				},
			},
		})

		map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next, { desc = "Repeat last treesitter move next" })
		map(
			{ "n", "x", "o" },
			",",
			ts_repeat_move.repeat_last_move_previous,
			{ desc = "Repeat last treesitter move previous" }
		)
		map({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
		map({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
		map({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
		map({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
	end,
}
