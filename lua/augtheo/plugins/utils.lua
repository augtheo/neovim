return {

    {
        "persistence.nvim",
        event = "VimEnter",
        after = function()
            require("persistence").setup()
            -- Restore Session
            vim.keymap.set("n", "<leader>qs", "<cmd>lua require('persistence').load()<cr>",
                { desc = "Restore Session" })

            -- Restore Last Session
            vim.keymap.set("n", "<leader>ql", "<cmd>lua require('persistence').load({ last = true })<cr>",
                { desc = "Restore Last Session" })

            -- Don't Save Current Session
            vim.keymap.set("n", "<leader>qd", "<cmd>lua require('persistence').stop()<cr>",
                { desc = "Don't Save Current Session" })
        end,
    },

    -- Better diagnostics list and others
    {
        "trouble.nvim",
        cmd = { "Trouble" },
        after = function()
            require("trouble").setup({
                modes = {
                    lsp = {
                        win = { position = "right" },
                    },
                },
            })
        end
        -- keys = {
        --         { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics (Trouble)" },
        --         { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
        --         { "<leader>cs", "<cmd>Trouble symbols toggle<cr>",                  desc = "Symbols (Trouble)" },
        --         { "<leader>cS", "<cmd>Trouble lsp toggle<cr>",                      desc = "LSP references/definitions/... (Trouble)" },
        --         { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                  desc = "Location List (Trouble)" },
        --         { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                   desc = "Quickfix List (Trouble)" },
        --         -- {
        -- 	"[q",
        -- 	function()
        -- 		if require("trouble").is_open() then
        -- 			require("trouble").prev({ skip_groups = true, jump = true })
        -- 		else
        -- 			local ok, err = pcall(vim.cmd.cprev)
        -- 			if not ok then
        -- 				vim.notify(err, vim.log.levels.ERROR)
        -- 			end
        -- 		end
        -- 	end,
        -- 	desc = "Previous Trouble/Quickfix Item",
        -- },
        -- {
        -- 	"]q",
        -- 	function()
        -- 		if require("trouble").is_open() then
        -- 			require("trouble").next({ skip_groups = true, jump = true })
        -- 		else
        -- 			local ok, err = pcall(vim.cmd.cnext)
        -- 			if not ok then
        -- 				vim.notify(err, vim.log.levels.ERROR)
        -- 			end
        -- 		end
        -- 	end,
        -- 	desc = "Next Trouble/Quickfix Item",
        -- },
        -- },
    },
    -- Finds and lists all of the TODO, HACK, BUG, etc comment
    -- in your project and loads them into a browsable list.
    {
        "todo-comments.nvim",
        after = function()
            require("todo-comments").setup({})
            -- Next Todo Comment (using Lua function)
            vim.keymap.set("n", "]t", function()
                require("todo-comments").jump_next()
            end, { desc = "Next Todo Comment" })

            -- Previous Todo Comment (using Lua function)
            vim.keymap.set("n", "[t", function()
                require("todo-comments").jump_prev()
            end, { desc = "Previous Todo Comment" })

            -- Todo (Trouble)
            vim.keymap.set("n", "<leader>xt", "<cmd>Trouble todo toggle<cr>", { desc = "Todo (Trouble)" })

            -- Todo/Fix/Fixme (Trouble)
            -- Note: You might need to check if 'TODO,FIX,FIXME' is correctly enclosed or passed as a string depending on your plugin configuration, but the common Neovim format is as follows:
            vim.keymap.set("n", "<leader>xT",
                "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>",
                { desc = "Todo/Fix/Fixme (Trouble)" })

            -- Todo (Telescope)
            vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Todo" })

            -- Todo/Fix/Fixme (Telescope)
            vim.keymap.set("n", "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",
                { desc = "Todo/Fix/Fixme" })
        end,
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        keys = {
        },
    },
}
