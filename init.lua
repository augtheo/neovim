vim.loader.enable() -- <- bytecode caching
do
    -- Set up a global in a way that also handles non-nix compat
    local ok
    ok, _G.nixInfo = pcall(require, vim.g.nix_info_plugin_name)
    if not ok then
        package.loaded[vim.g.nix_info_plugin_name] = setmetatable({}, {
            __call = function(_, default) return default end
        })
        _G.nixInfo = require(vim.g.nix_info_plugin_name)
        -- If you always use the fetcher function to fetch nix values,
        -- rather than indexing into the tables directly,
        -- it will use the value you specified as the default
        -- TODO: for non-nix compat, vim.pack.add in another file and require here.
    end
    nixInfo.isNix = vim.g.nix_info_plugin_name ~= nil
    ---@module 'lzextras'
    ---@type lzextras | lze
    nixInfo.lze = setmetatable(require('lze'), getmetatable(require('lzextras')))
    function nixInfo.get_nix_plugin_path(name)
        return nixInfo(nil, "plugins", "lazy", name) or nixInfo(nil, "plugins", "start", name)
    end
end
nixInfo.lze.register_handlers {
    {
        -- adds an `auto_enable` field to lze specs
        -- if true, will disable it if not installed by nix.
        -- if string, will disable if that name was not installed by nix.
        -- if a table of strings, it will disable if any were not.
        spec_field = "auto_enable",
        set_lazy = false,
        modify = function(plugin)
            if vim.g.nix_info_plugin_name then
                if type(plugin.auto_enable) == "table" then
                    for _, name in pairs(plugin.auto_enable) do
                        if not nixInfo.get_nix_plugin_path(name) then
                            plugin.enabled = false
                            break
                        end
                    end
                elseif type(plugin.auto_enable) == "string" then
                    if not nixInfo.get_nix_plugin_path(plugin.auto_enable) then
                        plugin.enabled = false
                    end
                elseif type(plugin.auto_enable) == "boolean" and plugin.auto_enable then
                    if not nixInfo.get_nix_plugin_path(plugin.name) then
                        plugin.enabled = false
                    end
                end
            end
            return plugin
        end,
    },
    {
        -- we made an options.settings.cats with the value of enable for our top level specs
        -- give for_cat = "name" to disable if that one is not enabled
        spec_field = "for_cat",
        set_lazy = false,
        modify = function(plugin)
            if vim.g.nix_info_plugin_name then
                if type(plugin.for_cat) == "string" then
                    plugin.enabled = nixInfo(false, "settings", "cats", plugin.for_cat)
                end
            end
            return plugin
        end,
    },
    -- From lzextras. This one makes it so that
    -- you can set up lsps within lze specs,
    -- and trigger lspconfig setup hooks only on the correct filetypes
    -- It is (unfortunately) important that it be registered after the above 2,
    -- as it also relies on the modify hook, and the value of enabled at that point
    nixInfo.lze.lsp,
}

-- NOTE: This config uses lzextras.lsp handler https://github.com/BirdeeHub/lzextras?tab=readme-ov-file#lsp-handler
-- Because we have the paths, we can set a more performant fallback function
-- for when you don't provide a filetype to trigger on yourself.
-- If you do provide a filetype, this will never be called.
nixInfo.lze.h.lsp.set_ft_fallback(function(name)
    local lspcfg = nixInfo.get_nix_plugin_path "nvim-lspconfig"
    if lspcfg then
        local ok, cfg = pcall(dofile, lspcfg .. "/lsp/" .. name .. ".lua")
        return (ok and cfg or {}).filetypes or {}
    else
        -- the less performant thing we are trying to avoid at startup
        return (vim.lsp.config[name] or {}).filetypes or {}
    end
end)

require('augtheo.autocommands')
require('augtheo.options')
require('augtheo.keymaps')

-- TODO: WTF do these options do?
vim.g.netrw_liststyle = 0
vim.g.netrw_banner = 0


-- NOTE: You will likely want to break this up into more files.
-- You can call this more than once.
-- You can also include other files from within the specs via an `import` spec.
-- see https://github.com/BirdeeHub/lze?tab=readme-ov-file#structuring-your-plugins
nixInfo.lze.load {
    { import = "augtheo.plugins.alpha", },
    { import = "augtheo.plugins.colorschemes", },
    { import = "augtheo.plugins.colorful-winsep", },
    { import = "augtheo.plugins.completion", },
    { import = "augtheo.plugins.lualine", },
    { import = "augtheo.plugins.markdown-preview" },
    { import = "augtheo.plugins.mini-files" },
    { import = "augtheo.plugins.mini-utils" },
    { import = "augtheo.plugins.git" },
    { import = "augtheo.plugins.noice" },
    { import = "augtheo.plugins.snacks", },
    { import = "augtheo.plugins.telescope", },
    { import = "augtheo.plugins.treesitter", },
    { import = "augtheo.plugins.utils", },
    { import = "augtheo.plugins.which-key" },
}

require("augtheo.lsp")
require("augtheo.lsp.format")
require("augtheo.lsp.lint")
require("augtheo.lsp.debug")
