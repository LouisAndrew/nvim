return {"nvim-tree/nvim-tree.lua", keys = {
  {   "<leader>ee",   "<cmd>:NvimTreeToggle<cr>"}
}, event = "VeryLazy", config = function() 

require("nvim-tree").setup()

end }
