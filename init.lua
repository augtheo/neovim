vim.loader.enable() -- <- bytecode caching
require("augtheo.nix")

require("augtheo.autocommands")
require("augtheo.options")
require("augtheo.keymaps")

-- TODO: WTF do these options do?
vim.g.netrw_liststyle = 0
vim.g.netrw_banner = 0

require("augtheo.plugins")

require("augtheo.lsp")
require("augtheo.lsp.format")
require("augtheo.lsp.lint")
require("augtheo.lsp.debug")
require("augtheo.lsp.testing")
