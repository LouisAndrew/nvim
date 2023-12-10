local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

ensure_packer()

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  use({
    "yamatsum/nvim-nonicons",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("nvim-nonicons").setup({})
    end,
  })
  -- telescopes
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    requires = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "fdschmidt93/telescope-egrepify.nvim",
    },
  })

  use("nvim-tree/nvim-tree.lua")

  -- Treesitter and LSP

  use({
    "nvim-treesitter/nvim-treesitter",
    { run = ":TSUpdate" },
  })
  use("nvim-treesitter/playground")

  use({
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
  })
  use("nvim-treesitter/nvim-tree-docs")

  use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })

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
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "L3MON4D3/LuaSnip" },
      { "saadparwaiz1/cmp_luasnip" },
    },
  })

  use("nvimtools/none-ls.nvim")
  use("stevearc/conform.nvim")

  use({
    "nvimdev/lspsaga.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("lspsaga").setup({})
    end,
  })

  use({
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({ auto_preview = false })
    end,
  })

  -- Sundown infavor of null-ls
  --[[   use({
    "nvimdev/guard.nvim",
    -- Builtin configuration, optional
    requires = {
      "nvimdev/guard-collection",
    },
  })
 ]]

  use("github/copilot.vim")

  -- cmd autocompletes
  use({
    "gelguy/wilder.nvim",
    config = function()
      local wilder = require("wilder")
      wilder.set_option(
        "renderer",
        wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
          border = "rounded",
          max_height = "75%", -- max height of the palette
          min_height = 0,     -- set to the same as 'max_height' for a fixed height window
          prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
          reverse = 0,        -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
        }))
      )
      wilder.setup({ modes = { ":" } })
    end,
  })

  -- snippets
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")

  -- LUALINE
  use({
    "nvim-lualine/lualine.nvim",
  })

  use({
    "akinsho/bufferline.nvim",
    tag = "*",
    config = function()
      require("bufferline").setup({})
    end,
  })

  -- git
  use({
    "NeogitOrg/neogit",
    requires = {
      { "nvim-lua/plenary.nvim" },      -- required
      { "nvim-telescope/telescope.nvim" }, -- optional
      { "sindrets/diffview.nvim" },     -- optional
      { "ibhagwan/fzf-lua" },           -- optional
    },
  })

  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  })

  -- theme
  use("xiyaowong/transparent.nvim")

  use({
    "jesseleite/nvim-noirbuddy",
    requires = { "tjdevries/colorbuddy.nvim", branch = "dev" },
  })

  use("m4xshen/autoclose.nvim")

  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })

  use("mbbill/undotree")

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

  -- eunuch-like
  use({ "chrisgrieser/nvim-genghis", requires = "stevearc/dressing.nvim" })

  -- neoclip
  use({
    "AckslD/nvim-neoclip.lua",
    requires = {
      -- you'll need at least one of these
      -- {'nvim-telescope/telescope.nvim'},
      -- {'ibhagwan/fzf-lua'},
    },
    config = function()
      require("neoclip").setup()
    end,
  })

  -- OBSIDIAN
  use({
    "epwalsh/obsidian.nvim",
    tag = "*", -- recommended, use latest release instead of latest commit
    requires = {
      "nvim-lua/plenary.nvim",
      "godlygeek/tabular",
      -- "preservim/vim-markdown"
    },
  })

  use("ekickx/clipboard-image.nvim")
end)
