require("remap")
require("plugins")
require("set")
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })

-- set system clipboard
vim.opt.clipboard = "unnamedplus"
vim.keymap.set("i", "<C-h>", "<Right>", { noremap = true, silent = true })
