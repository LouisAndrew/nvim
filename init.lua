require("remap")
require("plugins")
require("set")

-- set system clipboard
vim.opt.clipboard = "unnamedplus"
vim.keymap.set("i", "<C-h>", "<Right>", { noremap = true, silent = true })
