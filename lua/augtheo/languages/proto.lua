return {
	category = "protobuf",
	filetypes = { "proto" },
	lsp = {
		name = "bufls",
		filetypes = { "proto" },
		cmd = { "buf", "lsp", "serve" },
	},
}
