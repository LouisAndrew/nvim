return {
	-- ltex_ls no good code actions. [https://github.com/valentjn/ltex-ls/issues/171]
	"barreiroleo/ltex_extra.nvim",
	ft = { "markdown", "tex" },
	dependencies = { "neovim/nvim-lspconfig" },
	config = function() end,
}
