return {
	category = "rust",
	filetypes = { "rust" },
	plugins = {
		{
			"rustaceanvim",
			lazy = false,
			for_cat = "rust",
			load = function(name)
				local lldb_cmd = vim.fn.exepath("lldb-dap") ~= "" and "lldb-dap" or "lldb-vscode"
				vim.g.rustaceanvim = {
					dap = {
						adapter = {
							type = "executable",
							command = lldb_cmd,
							name = "lldb",
						},
					},
					tools = {
						hover_actions = { auto_focus = true },
					},
				}
				vim.cmd.packadd(name)
			end,
		},
	},
	neotest = function()
		local ok, adapter = pcall(require, "rustaceanvim.neotest")
		if ok then
			return adapter
		end
	end,
}
