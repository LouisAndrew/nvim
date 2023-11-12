return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use "mg979/vim-visual-multi"

  use {
    "folke/flash.nvim",
    config = function()
      require('flash').setup({})

      local ok, flash = pcall(require, 'flash')
      if not ok then
        return
      end

      vim.keymap.set({ "n", "x", "o" }, "f", function() flash.jump() end, { desc = "Flash" })
      vim.keymap.set({ "n", "o", "x" }, "F", function() flash.treesitter() end, { desc = "Flash Treesitter" })
      vim.keymap.set("o", "r", function() flash.remote() end, { desc = "Remote Flash" })
      vim.keymap.set({ "o", "x" }, "R", function() flash.treesitter_search() end, { desc = "Flash Treesitter Search" })
      vim.keymap.set({ "c" }, "<c-s>", function() flash.toggle() end, { desc = "Toggle Flash Search" })
    end
  }

  use{
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  }
end)
