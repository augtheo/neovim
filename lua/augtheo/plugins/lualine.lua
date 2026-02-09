return {
    "lualine.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
        local icons = {
            git = require("augtheo.icons").git,
            diagnostics = require("augtheo.icons").diagnostics,
        }
        local diagnostics = {
            "diagnostics",
            always_visible = false,
            colored = true,
            sections = { "error", "warn" },
            sources = { "nvim_diagnostic" },
            symbols = { error = icons.diagnostics.Error, warn = icons.diagnostics.Warn },
        }

        local diff = {
            "diff",
            colored = true,
            padding = { left = 1, right = 1 },
            symbols = { added = icons.git.Add, modified = icons.git.Mod, removed = icons.git.Remove },
        }

        require('lualine').setup({
            options = {
                icons_enabled = false,
                theme = nixInfo("onedark_dark", "settings", "colorscheme"),
                component_separators = '',
                section_separators = '',
                disabled_filetypes = { "alpha" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch" },
                lualine_c = {
                    diff,
                },
                lualine_x = {
                    diagnostics,
                },
                lualine_y = {
                    {
                        'filename',
                        path = 1,
                        status = true,
                    },
                },
            },
            tabline = {
                lualine_a = { { "buffers", use_mode_colors = true } },
                lualine_z = { { "tabs", use_mode_colors = true } },
            },
        })
    end,
}
