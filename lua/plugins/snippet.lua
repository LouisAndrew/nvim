return {
	"L3MON4D3/LuaSnip",
	dependencies = {
		"saadparwaiz1/cmp_luasnip",
	},
	version = "v2.*",
	build = "make install_jsregexp",
	event = "BufEnter",
	config = function()
		local ls = require("luasnip")
		local types = require("luasnip.util.types")

		ls.setup({
			update_events = { "TextChanged", "TextChangedI" },
			ext_opts = {
				[types.insertNode] = {
					active = {
						hl_group = "LuaSnipInsertActive",
					},
					passive = {
						hl_group = "LuaSnipInsertPassive",
					},
				},
				[types.choiceNode] = {
					active = {
						virt_text = { { "<-", "LuaLineDiffChange" } },
						hl_mode = "combine",
					},
				},
			},
			ext_base_prio = 200,
			ext_prio_increase = 2,
			history = true,
		})

		vim.keymap.set({ "i" }, "<C-o>", function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			end
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<C-;>", function()
			ls.jump(-1)
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<C-y>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, { silent = true })

		require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
	end,
}
