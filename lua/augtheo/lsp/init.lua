require("lze").load({
	{
		"nvim-lspconfig",
		auto_enable = true,
		-- NOTE: define a function for lsp,
		-- and it will run for all specs with type(plugin.lsp) == table
		-- when their filetype trigger loads them
		lsp = function(plugin)
			vim.lsp.config(plugin.name, plugin.lsp or {})
			vim.lsp.enable(plugin.name)
		end,
	},
	{ import = "augtheo.lsp.lang.python" },
	{ import = "augtheo.lsp.lang.nix" },
	{ import = "augtheo.lsp.lang.go" },
	{ import = "augtheo.lsp.lang.rust" },
	{ import = "augtheo.lsp.lang.lua" },
})

require("augtheo.lsp.on_attach")
require("augtheo.lsp.diagnostic")
