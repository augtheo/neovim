return {
	{
		"gitsigns.nvim",
		event = "DeferredUIEnter",
		after = function()
			local gs = require("gitsigns")
			gs.setup({
				on_attach = function(bufnr)
					local function map(mode, l, r, desc)
						vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
					end

					map("n", "]c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gs.nav_hunk("next")
						end
					end, "Next hunk")
					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gs.nav_hunk("prev")
						end
					end, "Previous hunk")

					map("n", "<leader>ghs", gs.stage_hunk, "Stage hunk")
					map("n", "<leader>ghr", gs.reset_hunk, "Reset hunk")
					map("v", "<leader>ghs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, "Stage hunk")
					map("v", "<leader>ghr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, "Reset hunk")
					map("n", "<leader>ghS", gs.stage_buffer, "Stage buffer")
					map("n", "<leader>ghR", gs.reset_buffer, "Reset buffer")
					map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo stage hunk")
					map("n", "<leader>ghp", gs.preview_hunk, "Preview hunk")
					map("n", "<leader>ghb", function()
						gs.blame_line({ full = true })
					end, "Blame line")
					map("n", "<leader>ghd", gs.diffthis, "Diff this")
					map("n", "<leader>gtb", gs.toggle_current_line_blame, "Toggle line blame")
					map("n", "<leader>gtd", gs.toggle_deleted, "Toggle deleted")
				end,
			})
		end,
	},

	{
		"gitlinker.nvim",
		event = "DeferredUIEnter",
		keys = {
			{ "<leader>gy", mode = { "n", "v" }, desc = "Copy git link" },
			{ "<leader>gY", mode = { "n", "v" }, desc = "Open git link in browser" },
		},
		after = function()
			require("gitlinker").setup()
			local actions = require("gitlinker.actions")
			vim.keymap.set({ "n", "v" }, "<leader>gY", function()
				local mode = vim.fn.mode():match("[vV]") and "v" or "n"
				require("gitlinker").get_buf_range_url(mode, { action_callback = actions.open_in_browser })
			end, { desc = "Open git link in browser" })
		end,
	},

	{
		"diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff view (working tree)" },
			{ "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close diff view" },
			{ "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "File history (buffer)" },
		},
	},

	{
		"octo.nvim",
		cmd = "Octo",
		keys = {
			{ "<leader>gop", "<cmd>Octo pr list<cr>", desc = "PR list" },
			{ "<leader>goi", "<cmd>Octo issue list<cr>", desc = "Issue list" },
			{ "<leader>goc", "<cmd>Octo pr create<cr>", desc = "Create PR" },
			{ "<leader>gor", "<cmd>Octo review start<cr>", desc = "Start review" },
			{ "<leader>gos", "<cmd>Octo search<cr>", desc = "Search" },
		},
		after = function()
			require("octo").setup()
		end,
	},
}
