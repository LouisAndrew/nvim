
vim.g.mapleader = " "

require("remap")
require("set")

-- set system clipboard
vim.opt.clipboard = "unnamedplus"
vim.keymap.set("i", "<C-h>", "<Right>", { noremap = true, silent = true })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end


vim.opt.rtp:prepend(lazypath)

require("lazy").setup({{import = "plugins"}})
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
