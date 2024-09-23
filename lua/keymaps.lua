-- n, v, i, t = mode names
local function termcodes(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)

local function create_spec()
	local ft_specfile = {
		["typescript"] = ".spec.ts",
		["javascript"] = ".spec.js",
		["typescriptreact"] = ".spec.tsx",
		["javascriptreact"] = ".spec.jsx",
		["go"] = "_test.go",
	}

	local ft = vim.bo.filetype
	local specfile = ft_specfile[ft]
	if specfile then
		vim.cmd("e %:r" .. specfile)
	end
end

local M = {
	i = {
		-- go to  beginning and end
		["<C-b>"] = { "<ESC>^i", "beginning of line" },
		["<C-e>"] = { "<End>", "end of line" },
		-- navigate within insert mode
		["<C-h>"] = { "<Left>", "move left" },
		["<C-l>"] = { "<Right>", "move right" },
		["<C-j>"] = { "<Down>", "move down" },
		["<C-k>"] = { "<Up>", "move up" },
		["<C-4>"] = { "<End>" },
		["<C-6>"] = { "<cmd>:norm ^<CR>" },
		["<S-Tab>"] = { "<cmd>:norm <<^<CR>" },
	},

	n = {
		["<ESC>"] = { "<cmd> noh <CR>", "no highlight" },
		["<leader>pv"] = { vim.cmd.Ex },
		["<leader>tn"] = { ":e %:h" }, -- adjacent
		["<leader>tt"] = { create_spec },
		["<leader>s"] = { "<cmd>:w<cr>" },

		["<leader>tw"] = { "<cmd>:tabclose<cr>" },
		["<leader>q"] = { "<cmd>:wqa<cr>" },
		["<leader>]"] = { "<cmd>:bnext<cr>" },
		["<leader>["] = { "<cmd>:bprev<cr>" },
		["<C-]>"] = { "<cmd>:bnext<cr>" },
		["<C-[>"] = { "<cmd>:bprev<cr>" },
		["<leader>bw"] = { "<cmd>:%bd|e#|bd#<cr>" },
		-- Customs
		["<S-j>"] = { "}", "skip bracket" },
		["<S-k>"] = { "{", "skip bracket up" },
		["<S-h>"] = { "^", "start of line" },
		["<S-l>"] = { "$", "end of line" },
		["'"] = { "*", "next occurence" },
		[";"] = { "#", "last occurence" },
		["<C-u>"] = { "<C-u>zz", "scroll page down" },
		["<C-d>"] = { "<C-d>zz", "scroll page up" },

		["<A-k>"] = { "O", "move line up" },

		["<leader>mk"] = { "<cmd> :m-2 <CR>", "line up" },
		["<leader>mj"] = { "<cmd> :m+ <CR>", "line down" },
		-- ["gh"] = { "<Plug>VSCodeCommentaryLine" },

		-- Copy all
		["<C-c>"] = { "<cmd> %y+ <CR>", "copy whole file" },

		-- line numbers

		["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
		["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },

		-- ALT+H
		["˙"] = { require("smart-splits").resize_left },
		-- ALT+J
		["¬"] = { require("smart-splits").resize_down },
		-- ALT+K
		["˚"] = { require("smart-splits").resize_up },
		-- ALT+L
		["∆"] = { require("smart-splits").resize_right },

		["<C-h>"] = { require("smart-splits").move_cursor_left },
		["<C-j>"] = { require("smart-splits").move_cursor_down },
		["<C-k>"] = { require("smart-splits").move_cursor_up },
		["<C-l>"] = { require("smart-splits").move_cursor_right },

		["<C-8>"] = { "zh" },
		["<C-9>"] = { "zl" },

		["<leader>'"] = { "gt" },
		["<leader>;"] = { "gT" },

		-- Window management
		["<leader>w"] = { "<cmd>:bd<cr>" },
		["<leader>W"] = { "<cmd>:q<cr>" },
		["<leader>tj"] = { "<cmd>:sp<cr>" },
		["<leader>tl"] = { "<cmd>:vsp<cr>" },

		["Q"] = { "@qj", "Fast macro, always save on Q" },
		["go"] = { "gx" },

		["<leader>t["] = { "<cmd>:tabprev<cr>" }, -- adjacent
		["<leader>t]"] = { "<cmd>:tabnext<cr>" }, -- spec file
	},

	t = { ["<C-x>"] = { termcodes("<C-\\><C-N>"), "escape terminal " } },

	v = {
		["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
		["<S-j>"] = { "}", "skip bracket" },
		["<S-k>"] = { "{", "skip bracket up" },
		["<S-h>"] = { "^", "start of line" },
		["<S-l>"] = { "$", "end of line" },
		["n"] = { "*", "next occurence" },
		["N"] = { "#", "last occurence" },
		["<C-l>"] = { "%" },
		["<C-k>"] = { ":call VSCodeNotify('editor.action.jumpToBracket') <CR>" },
		["s"] = { "<Plug>(nvim-surround-visual)" },
	},

	x = {
		["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
		["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		-- Don't copy the replaced text after pasting in visual mode
		-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
		["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
		["Q"] = { ":norm @q<CR>", "Fast macro, always save on Q" },
	},
}

for mode, t in pairs(M) do
	for key, remap in pairs(t) do
		vim.keymap.set(mode, key, remap[1], remap.opts)
	end
end
