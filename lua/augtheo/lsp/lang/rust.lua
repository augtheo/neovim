return {
	{
		"rustaceanvim",
		lazy = false,
		for_cat = "rust",
		load = function(name)
			-- vim.g.rustaceanvim must be set before rustaceanvim is loaded
			-- lldb-dap is the modern name (lldb 14+); fall back to lldb-vscode for older builds
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
}
