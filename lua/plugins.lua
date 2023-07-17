return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use {
    'stevearc/oil.nvim',
    config = function() require('oil').setup() end
  }

  use "mg979/vim-visual-multi"

  use {
    "folke/flash.nvim",
    config = function()
      require('flash').setup({
        search = {
          mode = function(str)
            return "\\<" .. str
          end,
        }, 
      })

      local ok, flash = pcall(require, 'flash')
      if not ok then
        return
      end

      vim.keymap.set({ "n", "x", "o" }, "f", function() flash.jump() end, {desc = "Flash" })
      vim.keymap.set({ "n", "o", "x" }, "F", function() flash.treesitter() end, {desc = "Flash Treesitter"})
      vim.keymap.set("o", "r", function() flash.remote() end, {desc = "Remote Flash" })
      vim.keymap.set({ "o", "x" },"R", function() flash.treesitter_search() end, {desc = "Flash Treesitter Search" })
      vim.keymap.set({ "c" }, "<c-s>", function() flash.toggle() end, {desc = "Toggle Flash Search" })
    end
  }
end)

