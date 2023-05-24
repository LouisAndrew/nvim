require("remap")
require("plugins")

vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
