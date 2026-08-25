require("lze").load({
	{
		"nvim-lint",
		auto_enable = true,
		event = "FileType",
		after = function(_)
			local languages = require("augtheo.languages")
			require("lint").linters_by_ft = languages.get_linters_by_ft()

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
})
