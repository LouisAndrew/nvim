return {
	"folke/flash.nvim",
	event = "BufEnter",
	config = function()
		require("flash").setup({
			labels = "asdjkl",
			modes = {
				search = {
					enabled = false,
				},
			},
		})

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
}
