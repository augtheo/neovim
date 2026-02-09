-- [[ Setting options ]]
-- See `:help vim.o`

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- allow .nvim.lua in current dir and parents (project config)
vim.o.exrc = false -- can be toggled off in that file to stop it from searching further

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Set highlight on search
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- TODO: Merge this with notify

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'


-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'


-- Make line numbers default
vim.wo.number = true
-- Make relative numbers default
vim.wo.relativenumber = true

-- Always show the statusline, and it spans the full width of the editor
vim.opt.laststatus = 3

-- Indent
-- vim.o.smarttab = true
vim.opt.cpoptions:append('I')
-- vim.o.smartindent = true
-- vim.o.autoindent = true
-- vim.o.softtabstop = 4
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- insert 2 spaces for a tab

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- stops line wrapping from being confusing
vim.o.breakindent = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Save undo history
vim.o.undofile = true

vim.opt.cmdheight = 0 -- more space in the neovim command line for displaying messages

vim.opt.termguicolors  = true -- set term gui colors (most terminals support this)

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,preview,noselect'

vim.opt.cursorline     = true                         -- highlight the current line
