return {
	{
		"bufls",
		for_cat = "protobuf",
		lsp = {
			filetypes = { "proto" },
			cmd = { "buf", "lsp", "serve" },
		},
	},
}
