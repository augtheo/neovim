return {
	{
		"gopls",
		for_cat = "go",
		-- if you don't provide the filetypes it asks lspconfig for them
		lsp = {
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
		},
	},
}
