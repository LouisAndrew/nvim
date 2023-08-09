require("remap")
require("plugins")

vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })

-- set system clipboard
vim.opt.clipboard = "unnamedplus"
