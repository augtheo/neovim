require("lze").load({
	{
		"conform.nvim",
		-- for_cat = 'format',
		auto_enable = true,
		-- cmd = { "" },
		-- event = "",
		-- ft = "",
		keys = {
			{ "<leader>FF", desc = "[F]ormat [F]ile" },
		},
		-- colorscheme = "",
		after = function(plugin)
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					lua = nixInfo(nil, "settings", "cats", "lua") and { "stylua" } or nil,
					python = nixInfo(nil, "settings", "cats", "python") and { "ruff_format", "ruff_organize_imports" }
						or nil,
				},
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
