return {
    {
        "mini.bracketed",
        after = function()
            require("mini.bracketed").setup()
        end,
        for_cat = 'general.always',
        event = "DeferredUIEnter",
    },

    {
        "mini.surround",
        after = function()
            require("mini.surround").setup()
        end,
        for_cat = 'general.always',
        event = "DeferredUIEnter",
    },

    {
        "mini.align",
        after = function()
            require("mini.align").setup()
        end,
        for_cat = 'general.always',
        event = "DeferredUIEnter",
    },

    {
        "mini.diff",
        for_cat = 'general.always',
        event = "DeferredUIEnter",
        after = function(plugin)
            require('mini.diff').setup({
                view = { style = "sign", signs = { add = "│", change = "│", delete = "┆" } }
            })
        end,
    },
}
