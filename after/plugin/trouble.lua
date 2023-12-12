require("trouble").setup({ auto_preview = false })
vim.keymap.set("n", "<leader>id", "<cmd>:TroubleToggle<cr>", { noremap = true, silent = true })
