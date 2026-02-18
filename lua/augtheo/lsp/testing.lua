require("lze").load({
	{
		"neotest",
		keys = {
			{ "<leader>tt", desc = "Test: Run Nearest" },
			{ "<leader>tf", desc = "Test: Run File" },
			{ "<leader>ts", desc = "Test: Run Suite" },
			{ "<leader>tl", desc = "Test: Run Last" },
			{ "<leader>to", desc = "Test: Output" },
			{ "<leader>tS", desc = "Test: Toggle Summary" },
			{ "<leader>td", desc = "Test: Debug Nearest" },
		},
		load = function(name)
			vim.cmd.packadd(name)
			vim.cmd.packadd("nvim-nio")
			vim.cmd.packadd("FixCursorHold-nvim")
			vim.cmd.packadd("neotest-python")
		end,
		after = function()
			local neotest = require("neotest")

			neotest.setup({
				adapters = {
					require("neotest-python")({
						dap = { justMyCode = false },
					}),
					require("rustaceanvim.neotest"),
				},
				status = { virtual_text = true },
				output = { open_on_run = true },
			})

			vim.keymap.set("n", "<leader>tt", function()
				neotest.run.run()
			end, { desc = "Test: Run Nearest" })

			vim.keymap.set("n", "<leader>tf", function()
				neotest.run.run(vim.fn.expand("%"))
			end, { desc = "Test: Run File" })

			vim.keymap.set("n", "<leader>ts", function()
				neotest.run.run(vim.fn.getcwd())
			end, { desc = "Test: Run Suite" })

			vim.keymap.set("n", "<leader>tl", function()
				neotest.run.run_last()
			end, { desc = "Test: Run Last" })

			vim.keymap.set("n", "<leader>to", function()
				neotest.output.open({ enter = true, auto_close = true })
			end, { desc = "Test: Output" })

			vim.keymap.set("n", "<leader>tS", function()
				neotest.summary.toggle()
			end, { desc = "Test: Toggle Summary" })

			vim.keymap.set("n", "<leader>td", function()
				neotest.run.run({ strategy = "dap" })
			end, { desc = "Test: Debug Nearest" })
		end,
	},
})
