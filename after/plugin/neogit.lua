local neogit = require("neogit")
neogit.setup({
  integrations = {
    telescope = true,
    diffview = true,
  },
  mappings = {
    popup = {
      ["?"] = "HelpPopup",
      ["A"] = "CherryPickPopup",
      ["D"] = "DiffPopup",
      ["M"] = "RemotePopup",
      ["P"] = "PushPopup",
      ["X"] = "ResetPopup",
      ["Z"] = "StashPopup",
      ["b"] = "BranchPopup",
      ["c"] = "CommitPopup",
      ["f"] = "FetchPopup",
      ["l"] = "LogPopup",
      ["m"] = "MergePopup",
      ["p"] = "PullPopup",
      ["r"] = "RebasePopup",
      ["v"] = "RevertPopup",
    },
  },
})

vim.keymap.set("n", "<leader>gg", neogit.open, {})
vim.keymap.set("n", "<leader>gd", "<cmd>:DiffviewOpen<cr>", {})
