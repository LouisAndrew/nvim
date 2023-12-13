
-- Cloned from https://github.com/jesseleite/nvim-noirbuddy/blob/master/lua/noirbuddy/init.lua

local M = {}

function M.setup()
  opts = opts or {}

  vim.api.nvim_command("set termguicolors")
  vim.api.nvim_command(string.format("set background=%s", 'dark'))

  require("theme/colors")
  require("theme/highlights")

  vim.api.nvim_command(string.format('let g:colors_name = "%s"', 'minimal_fedu'))
end

return M
