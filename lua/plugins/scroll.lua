return {
	"karb94/neoscroll.nvim",
	config = function()
		local utils = require("utils")

		require("neoscroll").setup({
			mappings = { "<C-u>", "<C-d>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
			easing = "cubic",
			pre_hook = function()
				print("pre")
				vim.g.DISPLAY_NAVIC = utils.CONST.falsy
			end,
			post_hook = function()
				vim.g.DISPLAY_NAVIC = utils.CONST.truthy
			end,
		})

		local t = {}
		-- Syntax: t[keys] = {function, {function arguments}}
		t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "100" } }
		t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "100" } }
		t["<C-y>"] = { "scroll", { "-0.10", "false", "100", nil } }
		t["<C-e>"] = { "scroll", { "0.10", "false", "100", nil } }
		t["zt"] = { "zt", { "250" } }
		t["zz"] = { "zz", { "250" } }
		t["zb"] = { "zb", { "250" } }

		require("neoscroll.config").set_mappings(t)
	end,
}
