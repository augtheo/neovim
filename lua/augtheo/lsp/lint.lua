-- nvim-lint gives even more diagnostics. It allows linters to report directly to diagnostics just like lsps do
require("lze").load({
	{
		"nvim-lint",
		auto_enable = true,
		-- for_cat = 'lint',
		-- cmd = { "" },
		event = "FileType",
		-- ft = "",
		-- keys = "",
		-- colorscheme = "",
		after = function(plugin)
			require("lint").linters_by_ft = {
				python = nixInfo(nil, "settings", "cats", "python") and { "ruff" } or {},
			}

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
})
