local M = {}

local telescopeUtilities = require("telescope.utils")
local telescopeMakeEntryModule = require("telescope.make_entry")
local plenaryStrings = require("plenary.strings")
local devIcons = require("nvim-web-devicons")
local telescopeEntryDisplayModule = require("telescope.pickers.entry_display")
local fileTypeIconWidth = plenaryStrings.strdisplaywidth(devIcons.get_icon("fname", { default = true }))

local function getPathAndTail(fileName)
    local bufferNameTail = telescopeUtilities.path_tail(fileName)
    local pathWithoutTail = require("plenary.strings").truncate(fileName, #fileName - #bufferNameTail, "")
    local pathToDisplay = telescopeUtilities.transform_path({
        path_display = { "truncate" },
    }, pathWithoutTail)
    return bufferNameTail, pathToDisplay
end

M.customFilePickerOpts = {
    entry_maker = function(line)
        local originalEntryMaker = telescopeMakeEntryModule.gen_from_file({})
        local originalEntryTable = originalEntryMaker(line)

        local displayer = telescopeEntryDisplayModule.create({
            separator = " ",
            items = {
                { width = nil },
                { width = nil },
                { remaining = true },
            },
        })

        originalEntryTable.display = function(entry)
            local tail, pathToDisplay = getPathAndTail(entry.value)
            local icon, iconHighlight = telescopeUtilities.get_devicons(tail)
            return displayer({
                { icon,          iconHighlight },
                tail,
                { pathToDisplay, "TelescopeResultsComment" },
            })
        end
        return originalEntryTable
    end,
}

M.customGrepPickerOpts = {
    entry_maker = function(line)
        local originalEntryMaker = telescopeMakeEntryModule.gen_from_vimgrep({})
        local originalEntryTable = originalEntryMaker(line)

        local displayer = telescopeEntryDisplayModule.create({
            separator = " ", -- Telescope will use this separator between each entry item
            items = {
                { width = nil },
                { width = nil },
                { width = nil }, -- Maximum path size, keep it short
                { remaining = true },
            },
        })

        originalEntryTable.display = function(entry)
            local tail, pathToDisplay = getPathAndTail(entry.filename)
            local icon, iconHighlight = telescopeUtilities.get_devicons(tail)
            local coordinates = ""
            if true then
                if entry.lnum then
                    if entry.col then
                        coordinates = string.format("%s:%s", entry.lnum, entry.col)
                    else
                        coordinates = string.format("%s", entry.lnum)
                    end
                end
            end

            return displayer({
                { icon,          iconHighlight },
                tail,
                { coordinates,   "TelescopeResultsLineNr" },
                { pathToDisplay, "TelescopeResultsComment" },
            })
        end

        return originalEntryTable
    end,
}
-- end define custom opts for pretty pickers
--

M.customDropDownOpts = require("telescope.themes").get_dropdown({
    borderchars = {
        preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
        results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
    },
})
M.find_files = function()
    require("telescope.builtin").find_files(M.customFilePickerOpts)
end

M.oldfiles = function()
    require("telescope.builtin").oldfiles(M.customFilePickerOpts)
end

M.live_grep = function()
    require("telescope.builtin").live_grep(M.customGrepPickerOpts)
end

M.buffers = function()
    require("telescope.builtin").buffers(M.customDropDownOpts)
end

M.find_in_dirs = function()
    require("telescope.builtin").find_files(
        vim.tbl_deep_extend("force", M.customFilePickerOpts, { cwd = vim.fn.input("Directory: ") })
    )
end

M.find_files_with_word = function()
    require("telescope.builtin").find_files(
        vim.tbl_deep_extend("force", M.customFilePickerOpts, { search_file = vim.fn.expand("<cword>") })
    )
end

M.grep = function()
    require("telescope.builtin").grep_string(
        vim.tbl_deep_extend("force", M.customGrepPickerOpts, { search = vim.fn.input("Search: ") })
    )
end

return M
