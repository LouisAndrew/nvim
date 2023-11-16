local neogit = require("neogit")
neogit.setup({
  integrations = {
    diffview = true,
  },
})

vim.keymap.set("n", "<leader>gg", neogit.open, {})
vim.keymap.set("n", "<leader>gd", "<cmd>:DiffviewOpen <cr>", {})
