return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    requires = { "nvim-lua/plenary.nvim" },
  })

  use({
    "nvim-telescope/telescope-file-browser.nvim",
  })

  use({
    "nvim-treesitter/nvim-treesitter",
    { run = ":TSUpdate" },
  })

  use({
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    requires = {
      --- Uncomment these if you want to manage LSP servers from neovim
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- LSP Support
      { "neovim/nvim-lspconfig" },
      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "L3MON4D3/LuaSnip" },
    },
  })

  use({
    "nvimdev/guard.nvim",
    -- Builtin configuration, optional
    requires = {
      "nvimdev/guard-collection",
    },
  })

  use({
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
  })

  use("tpope/vim-fugitive")

  use("m4xshen/autoclose.nvim")

  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })

  use("github/copilot.vim")

  use({
    "jesseleite/nvim-noirbuddy",
    requires = { "tjdevries/colorbuddy.nvim", branch = "dev" },
    config = function()
      require("noirbuddy").setup({
        preset = "minimal",
        colors = {
          primary = "#e6d1aa",
        },
      })
    end,
  })

  use("mg979/vim-visual-multi")

  use({
    "folke/flash.nvim",
    config = function()
      require("flash").setup({})

      local ok, flash = pcall(require, "flash")
      if not ok then
        return
      end

      vim.keymap.set({ "n", "x", "o" }, "f", function()
        flash.jump()
      end, { desc = "Flash" })
      vim.keymap.set({ "n", "o", "x" }, "F", function()
        flash.treesitter()
      end, { desc = "Flash Treesitter" })
      vim.keymap.set("o", "r", function()
        flash.remote()
      end, { desc = "Remote Flash" })
      vim.keymap.set({ "o", "x" }, "R", function()
        flash.treesitter_search()
      end, { desc = "Flash Treesitter Search" })
      vim.keymap.set({ "c" }, "<c-s>", function()
        flash.toggle()
      end, { desc = "Toggle Flash Search" })
    end,
  })

  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  })
end)
