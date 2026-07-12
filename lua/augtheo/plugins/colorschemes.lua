return {
	{
		-- lze specs need a name
		"trigger_colorscheme",
		-- lazy loaded colorscheme.
		-- This means you will need to add the colorscheme you want to lze sometime before VimEnter is done
		event = "VimEnter",
		-- Also, lze can load more than just plugins.
		-- The default load field contains vim.cmd.packadd
		-- Here we override it to schedule when our colorscheme is loaded
		load = function(_name)
			-- schedule so it runs after VimEnter
			vim.schedule(function()
				vim.cmd.colorscheme(nixInfo("catppuccin", "settings", "colorscheme"))
				vim.schedule(function()
					-- catppuccin mocha mauve
					vim.cmd([[hi LineNr guifg=#cba6f7]])
				end)
			end)
		end,
	},
	{
		-- NOTE: view these names in the info plugin!
		-- :lua nixInfo.lze.debug.display(nixInfo.plugins)
		-- The display function is from lzextras
		"onedarkpro.nvim",
		auto_enable = true, -- <- auto enable is useful here
		colorscheme = { "onedark", "onedark_dark", "onedark_vivid", "onelight" },
	},
	{
		"vim-moonfly-colors",
		auto_enable = true,
		colorscheme = "moonfly",
	},
	{
		"catppuccin",
		-- auto_enable checks nixInfo.get_nix_plugin_path(value); the nix attribute is
		-- catppuccin-nvim, not catppuccin, so we must pass the correct name here.
		auto_enable = "catppuccin-nvim",
		colorscheme = {
			"catppuccin",
			"catppuccin-latte",
			"catppuccin-frappe",
			"catppuccin-macchiato",
			"catppuccin-mocha",
		},
		-- load is called (via ColorSchemePre) before colors/catppuccin.vim is sourced.
		-- We cannot use packadd here because the nix package name differs from the spec
		-- name — packadd("catppuccin") would be a no-op. Instead, resolve the real nix
		-- store path and prepend it to rtp so require('catppuccin') succeeds.
		load = function(_name)
			local path = nixInfo.get_nix_plugin_path("catppuccin-nvim")
			if path then
				vim.opt.rtp:prepend(path)
			end
			require("catppuccin").setup({
				flavour = "mocha",
				integrations = {
					blink_cmp = true,
					gitsigns = true,
					mini = { enabled = true },
					noice = true,
					telescope = { enabled = true },
					treesitter = true,
					which_key = true,
					lsp_trouble = true,
					native_lsp = {
						enabled = true,
						underlines = {
							errors = { "undercurl" },
							hints = { "undercurl" },
							warnings = { "undercurl" },
							information = { "undercurl" },
						},
					},
				},
			})
		end,
	},
}
