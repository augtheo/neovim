return {
    {
        "gitsigns.nvim",
        after = function()
            require("gitsigns").setup()
        end,
        event = "DeferredUIEnter",
    },

    {
        "vim-fugitive",
        cmd = "Git"
    },

    {
        "gitlinker.nvim",
        after = function()
            require("gitlinker").setup()
        end,
        event = "DeferredUIEnter",
    },

    {
        "diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },

    },
}
