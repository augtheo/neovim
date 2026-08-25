return {
	category = "lua",
	filetypes = { "lua" },
	plugins = {
		{
			"lazydev.nvim",
			auto_enable = true,
			cmd = { "LazyDev" },
			ft = "lua",
			after = function(_)
				require("lazydev").setup({
					library = {
						{ words = { "nixInfo%.lze" }, path = nixInfo("lze", "plugins", "start", "lze") .. "/lua" },
						{
							words = { "nixInfo%.lze" },
							path = nixInfo("lzextras", "plugins", "start", "lzextras") .. "/lua",
						},
					},
				})
			end,
		},
	},
	lsp = {
		name = "lua_ls",
		filetypes = { "lua" },
		settings = {
			Lua = {
				signatureHelp = { enabled = true },
				diagnostics = {
					globals = { "nixInfo", "vim" },
					disable = { "missing-fields" },
				},
			},
		},
	},
	formatters = { "stylua" },
}
