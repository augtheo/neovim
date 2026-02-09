vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- TODO: merge this config and notify

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`


-- [[Move text up and down]]
-- These mappings use the 'move' command (:m) to shift lines in Normal (n), 
-- Insert (i), and Visual (v) modes while maintaining indenting.
-- Normal Mode
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = 'Move Current Line Down' })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = 'Move Current Line Up' })
-- Insert Mode
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = 'Move Current Line Down' })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = 'Move Current Line Up' })
-- Visual Mode
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = 'Move Selected Lines Down' })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = 'Move Selected Lines Up' })

-- [[Centered Navigation/Search]]
-- The 'zz' command is appended to common movement and search jumps 
-- to ensure the cursor line is always vertically centered on the screen.
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Scroll Down and Center' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Scroll Up and Center' })
vim.keymap.set("n", "n", "nzz", { desc = 'Next Search Match and Center' })
vim.keymap.set("n", "N", "Nzz", { desc = 'Previous Search Match and Center' })
vim.keymap.set("n", "*", "*zz", { desc = 'Search Word Forward and Center' })
vim.keymap.set("n", "#", "#zz", { desc = 'Search Word Backward and Center' })
vim.keymap.set("n", "g*", "g*zz", { desc = 'Search Partial Word Forward and Center' })
vim.keymap.set("n", "g#", "g#zz", { desc = 'Search Partial Word Backward and Center' })

-- TODO (Check if the following work better inside folds)
-- vim.keymap.set("n", "n", "nzzzv", { desc = 'Next Search Result' })
-- vim.keymap.set("n", "N", "Nzzzv", { desc = 'Previous Search Result' })

vim.keymap.set("n", "<leader><leader>[", "<cmd>bprev<CR>", { desc = 'Previous buffer' })
vim.keymap.set("n", "<leader><leader>]", "<cmd>bnext<CR>", { desc = 'Next buffer' })
vim.keymap.set("n", "<leader><leader>l", "<cmd>b#<CR>", { desc = 'Last buffer' })
vim.keymap.set("n", "<leader><leader>d", "<cmd>bdelete<CR>", { desc = 'delete buffer' })

-- see help sticky keys on windows
vim.cmd([[command! W w]])
vim.cmd([[command! Wq wq]])
vim.cmd([[command! WQ wq]])
vim.cmd([[command! Q q]])

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


-- You should instead use these keybindings so that they are still easy to use, but dont conflict
vim.keymap.set({"v", "x", "n"}, '<leader>y', '"+y', { noremap = true, silent = true, desc = 'Yank to clipboard' })
vim.keymap.set({"n", "v", "x"}, '<leader>Y', '"+yy', { noremap = true, silent = true, desc = 'Yank line to clipboard' })
vim.keymap.set({"n", "v", "x"}, '<C-a>', 'gg0vG$', { noremap = true, silent = true, desc = 'Select all' })
vim.keymap.set({'n', 'v', 'x'}, '<leader>p', '"+p', { noremap = true, silent = true, desc = 'Paste from clipboard' })
vim.keymap.set('i', '<C-p>', '<C-r><C-p>+', { noremap = true, silent = true, desc = 'Paste from clipboard from within insert mode' })
vim.keymap.set("x", "<leader>P", '"_dP', { noremap = true, silent = true, desc = 'Paste over selection without erasing unnamed register' })

