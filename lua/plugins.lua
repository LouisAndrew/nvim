return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'ggandor/leap.nvim',
  }

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
end)
