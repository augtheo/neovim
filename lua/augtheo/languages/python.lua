--- Resolve the python executable for debugpy.
--- Checks VIRTUAL_ENV, then .venv in cwd (uv/poetry), then falls back to python3.
local function get_python_path()
	local venv = os.getenv("VIRTUAL_ENV")
	if venv then
		return venv .. "/bin/python"
	end
	local cwd = vim.fn.getcwd()
	local venv_python = cwd .. "/.venv/bin/python"
	if vim.fn.executable(venv_python) == 1 then
		return venv_python
	end
	return "python3"
end

return {
	category = "python",
	filetypes = { "python" },
	lsp = {
		name = "pyright",
		filetypes = { "python" },
	},
	formatters = { "ruff_format", "ruff_organize_imports" },
	linters = { "ruff" },
	dap = function()
		pcall(function()
			require("dap-python").setup(get_python_path())
		end)
	end,
	neotest = function()
		local ok, adapter = pcall(require, "neotest-python")
		if ok then
			return adapter({
				dap = { justMyCode = false },
			})
		end
	end,
}
