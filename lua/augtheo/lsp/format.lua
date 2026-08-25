require("lze").load({
	{
		"conform.nvim",
		auto_enable = true,
		keys = {
			{ "<leader>FF", desc = "[F]ormat [F]ile" },
		},
		after = function(_)
			local conform = require("conform")
			local languages = require("augtheo.languages")

			conform.setup({
				formatters_by_ft = languages.get_formatters_by_ft(),
			})

			vim.keymap.set({ "n", "v" }, "<leader>FF", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "[F]ormat [F]ile" })
		end,
	},
})
