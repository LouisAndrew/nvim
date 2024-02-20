local utils = require("utils")

local primary_font = "Varys"
local fallbacks = "nonicons,codicon,octicons"

local fontheight_base = 13
local fontheight = {
	value = fontheight_base,
	increment = 1,
}

local fontwidth_base = 8
local fontwidth = {
	value = fontwidth_base,
	increment = 1,
}

local function setguifont()
	local gf = primary_font .. ":h" .. fontheight.value .. ":w" .. fontwidth.value .. ":l," .. fallbacks
	local setcmd = "set guifont=" .. gf
	vim.cmd(setcmd)
end

local function guifontscale(n)
	return function()
		if n == 0 then
			fontheight.value = fontheight_base
			fontwidth.value = fontwidth_base
		else
			fontheight.value = fontheight.value + fontheight.increment * n
			fontwidth.value = fontwidth.value + fontwidth.increment * n
		end

		setguifont()
	end
end

vim.keymap.set("n", "<D-=>", guifontscale(1), { noremap = true })
vim.keymap.set("n", "<D-->", guifontscale(-1), { noremap = true })
vim.keymap.set("n", "<D-0>", guifontscale(0), { noremap = true })

vim.opt.linespace = 8
vim.cmd("source " .. utils.nvim_config_path .. "/macmap.vim")
setguifont()
