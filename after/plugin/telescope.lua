local builtin = require("telescope.builtin")
local telescope = require("telescope")

local actions = require("telescope.actions")
local fb_actions = telescope.extensions.file_browser.actions

local default_maps = {
  i = {
    ["<C-l>"] = actions.file_vsplit,
    ["<C-j>"] = actions.file_split,
  },
}

telescope.setup({
  pickers = {
    find_files = {
      mappings = default_maps,
    },
    buffers = {
      mappings = default_maps,
    },
    live_grep = {
      mappings = default_maps,
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    file_browser = {
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          ["<C-l>"] = actions.file_vsplit,
          ["<C-j>"] = actions.file_split,
          ["<C-h>"] = fb_actions.goto_cwd,
          ["<C-c>"] = fb_actions.create,
          ["<C-r>"] = fb_actions.rename,
          ["<C-d>"] = fb_actions.remove,
          ["<C-t>"] = actions.file_tab,
        },
      },
    },
  },
})

telescope.load_extension("file_browser")
telescope.load_extension("fzf")

vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
-- vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})
vim.keymap.set("n", "<leader>pc", builtin.grep_string, {})
vim.keymap.set("n", "<leader>ph", builtin.help_tags, {})

vim.keymap.set("n", "<leader>pe", ":Telescope file_browser<CR>", {})
