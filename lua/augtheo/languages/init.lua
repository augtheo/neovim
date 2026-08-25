local M = {}

local languages = {
	require("augtheo.languages.csharp"),
	require("augtheo.languages.go"),
	require("augtheo.languages.lua"),
	require("augtheo.languages.nix"),
	require("augtheo.languages.proto"),
	require("augtheo.languages.python"),
	require("augtheo.languages.rust"),
}

---Check if a language toolchain is enabled in the current configuration.
---@param lang table
---@return boolean
function M.is_enabled(lang)
	if not lang.category then
		return true
	end
	if nixInfo and nixInfo.isNix then
		return nixInfo(false, "settings", "cats", lang.category) == true
	end
	return true
end

---Get active language modules.
---@return table[]
function M.get_active_languages()
	local active = {}
	for _, lang in ipairs(languages) do
		if M.is_enabled(lang) then
			table.insert(active, lang)
		end
	end
	return active
end

---Get all conform formatters mapped by filetype from active language modules.
---@return table<string, string[]>
function M.get_formatters_by_ft()
	local formatters = {}
	for _, lang in ipairs(M.get_active_languages()) do
		if lang.formatters and lang.filetypes then
			for _, ft in ipairs(lang.filetypes) do
				formatters[ft] = lang.formatters
			end
		end
	end
	return formatters
end

---Get all nvim-lint linters mapped by filetype from active language modules.
---@return table<string, string[]>
function M.get_linters_by_ft()
	local linters = {}
	for _, lang in ipairs(M.get_active_languages()) do
		if lang.linters and lang.filetypes then
			for _, ft in ipairs(lang.filetypes) do
				linters[ft] = lang.linters
			end
		end
	end
	return linters
end

---Get all neotest adapters from active language modules.
---@return any[]
function M.get_test_adapters()
	local adapters = {}
	for _, lang in ipairs(M.get_active_languages()) do
		if type(lang.neotest) == "function" then
			local adapter = lang.neotest()
			if adapter then
				table.insert(adapters, adapter)
			end
		end
	end
	return adapters
end

---Initialize DAP configurations for active language modules.
function M.setup_dap()
	for _, lang in ipairs(M.get_active_languages()) do
		if type(lang.dap) == "function" then
			lang.dap()
		end
	end
end

---Get all lze specs for LSP and language-specific plugins.
---@return table[]
function M.get_lze_specs()
	local specs = {
		{
			"nvim-lspconfig",
			auto_enable = true,
			lsp = function(plugin)
				vim.lsp.config(plugin.name, plugin.lsp or {})
				vim.lsp.enable(plugin.name)
			end,
		},
	}

	for _, lang in ipairs(languages) do
		if lang.lsp then
			table.insert(specs, {
				lang.lsp.name,
				for_cat = lang.category,
				lsp = lang.lsp,
			})
		end
		if lang.plugins then
			for _, plugin_spec in ipairs(lang.plugins) do
				table.insert(specs, plugin_spec)
			end
		end
	end

	return specs
end

---Setup language orchestrator and load language plugins.
function M.setup()
	require("lze").load(M.get_lze_specs())
end

return M
