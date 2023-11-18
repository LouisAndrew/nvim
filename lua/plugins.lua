return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-tree/nvim-web-devicons")

	-- telescopes
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		requires = { "nvim-lua/plenary.nvim" },
	})

	use({
		"nvim-telescope/telescope-file-browser.nvim",
	})

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
		},
	})

	use("onsails/lspkind.nvim")
	use({
		"nvimdev/lspsaga.nvim",
		after = "nvim-lspconfig",
		config = function()
			require("lspsaga").setup({})
		end,
	})

	use({
		"nvimdev/guard.nvim",
		-- Builtin configuration, optional
		requires = {
			"nvimdev/guard-collection",
		},
	})

	use("github/copilot.vim")

	-- snippets
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	-- LUALINE
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	-- git
	use({
		"NeogitOrg/neogit",
		requires = {
			{ "nvim-lua/plenary.nvim" }, -- required
			{ "nvim-telescope/telescope.nvim" }, -- optional
			{ "sindrets/diffview.nvim" }, -- optional
			{ "ibhagwan/fzf-lua" }, -- optional
		},
	})

	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	-- theme

	use({
		"jesseleite/nvim-noirbuddy",
		requires = { "tjdevries/colorbuddy.nvim", branch = "dev" },
	})

	use({
		"startup-nvim/startup.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("startup").setup()
		end,
	})

	-- misc
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
end)
