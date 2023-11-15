local builtin = require("telescope.builtin")
local telescope = require("telescope")

local fb_actions = telescope.extensions.file_browser.actions

telescope.setup({
  extensions = {
    file_browser = {
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
          ["<C-h>"] = fb_actions.goto_cwd,
          ["<C-c>"] = fb_actions.create,
          ["<C-r>"] = fb_actions.rename,
          -- ["<C-m>"] = fb_actions.move,
          ["<C-d>"] = fb_actions.remove,
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  },
})

telescope.load_extension("file_browser")

vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})
vim.keymap.set("n", "<leader>pe", ":Telescope file_browser<CR>", {})
