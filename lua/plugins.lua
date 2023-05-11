return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'ggandor/leap.nvim',
    config = function()
      require("leap").add_default_mappings()
    end
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use "mg979/vim-visual-multi"
end)
