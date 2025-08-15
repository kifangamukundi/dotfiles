return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufReadPost" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "..." },
				},
				current_line_blame = true,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 1000,
				},
				linehl = false,
			})
		end,
	},
	{
		"tpope/vim-fugitive",
		config = function()
			local map = vim.keymap.set

			map("n", "<leader>g", "<cmd>:0Git<CR>", { desc = "Git status" })
			-- s Stage (add) the file or hunk under the cursor.
			-- u Unstage (reset) the file or hunk under the cursor.
			-- dd Perform a |:Gdiffsplit| on the file under the cursor.
			-- cc Create a commit.
			-- ca Amend the last commit and edit the message.
			-- ce Amend the last commit without editing the message.
			-- cb<Space> Populate command line with ":Git branch ".
			-- co<Space> Populate command line with ":Git checkout ".
			-- r<Space> Populate command line with ":Git rebase ".
			-- rr Continue the current rebase.
			-- ra Abort the current rebase.
			-- cm<Space> Populate command line with ":Git merge ".

			map("n", "<leader>vl", "<cmd>:Gclog %<CR>", { desc = "Git log quick fix list" })
			map("n", "<leader>vd", "<cmd>:G diff %<CR>", { desc = "Git diff" })

			local fugitive_augroup = vim.api.nvim_create_augroup("Fugitive", { clear = true })

			vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
				group = fugitive_augroup,
				pattern = "fugitive://*",
				callback = function()
					vim.opt_local.bufhidden = "delete"
					vim.keymap.set("n", "<leader>vgp", ":Git push<CR>", { buffer = true, desc = "Git push" })

					vim.keymap.set("n", "<leader>vgr", function()
						local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]
						if branch == "main" then
							vim.notify(
								"You're on main — use <leader>gu (fast-forward pull) instead",
								vim.log.levels.WARN
							)
						else
							vim.cmd(":Git rebase origin/main")
						end
					end, { buffer = true, desc = "Rebase onto origin/main (safe)" })

					vim.keymap.set("n", "<leader>vgu", function()
						local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]
						if branch == "main" then
							vim.cmd(":Git pull --ff-only")
						else
							vim.cmd(":Git pull --rebase origin main")
						end
					end, { buffer = true, desc = "Smart Git pull" })

					-- Group multiple commits from a feature branch into a single commit
					map("n", "<leader>vgs", function()
						local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]
						if branch == "main" then
							vim.notify("You're on main — no squashing here!", vim.log.levels.WARN)
							return
						end
						local base = vim.fn.systemlist("git merge-base main HEAD")[1]
						if base == "" then
							vim.notify("Could not find merge base with mains", vim.log.levels.ERROR)
							return
						end
						vim.cmd(":Git rebase -i " .. base)
					end, { desc = "Interactive squash branch into 1 commit from main" })
				end,
			})
		end,
	},
}
