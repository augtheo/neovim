return {
	category = "nix",
	filetypes = { "nix" },
	lsp = {
		name = "nixd",
		filetypes = { "nix" },
		settings = {
			nixd = {
				nixpkgs = {
					expr = [[import <nixpkgs> {}]],
				},
				options = {},
				formatting = {
					command = { "nixfmt" },
				},
				diagnostic = {
					suppress = {
						"sema-escaping-with",
					},
				},
			},
		},
	},
}
