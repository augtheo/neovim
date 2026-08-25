return {
	category = "go",
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	lsp = {
		name = "gopls",
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
	},
	neotest = function()
		local ok, adapter = pcall(require, "neotest-go")
		if ok then
			return adapter({})
		end
	end,
}
