local opt = vim.opt
-- opt.nu = true
opt.nu = true
opt.rnu = true
opt.numberwidth = 4

-- indents etc
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.wrap = false
opt.laststatus = 3

opt.smartindent = true

-- search
opt.ignorecase = true
opt.smartcase = true

-- backspace
opt.backspace = "indent,eol,start"

-- split
opt.splitright = true
opt.splitbelow = true

opt.background = "dark" -- set this to dark or light

opt.iskeyword:append("-")
opt.cursorline = true
opt.cursorlineopt = "number"

-- " Disable swapfile and save undo {{{=====
-- opt.noswapfile = true -- " Fuck you swapfiles
opt.undofile = true
vim.cmd("set noswapfile")

vim.keymap.set("n", "<leader>pd", function()
	local bufinfos = vim.fn.getbufinfo({ buflisted = true })
	vim.tbl_map(function(bufinfo)
		if bufinfo.changed == 0 and (not bufinfo.windows or #bufinfo.windows == 0) then
			-- vim.api.nvim_buf_delete(bufinfo.bufnr, { force = false, unload = false })
			vim.cmd("bd " .. tostring(bufinfo.bufnr))
		end
	end, bufinfos)
end, { silent = true, desc = "Wipeout all buffers not shown in a window" })

local global_group = vim.api.nvim_create_augroup("Global Highlights", { clear = true })
local md_group = vim.api.nvim_create_augroup("MD Highlights", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.md" },
	group = md_group,
	callback = function()
		vim.cmd("syntax match MDDone /@DONE/")
		vim.cmd("syntax match MDReminder /@REMINDER/")
		vim.cmd("syntax match MDDate /@\\d\\{2}\\.\\d\\{2}\\.\\d\\{4}/")
		vim.cmd("syntax match MDDate /@\\d\\{2}\\.\\d\\{2}\\.\\d\\{2}/")
		vim.cmd("syntax match MDDate /@\\d\\{2}\\.\\d\\{4}/")
		vim.cmd("syntax match Bold /\\*\\*.*\\*\\*/")

		local o = vim.opt
		o.conceallevel = 2
		-- o.conceallevel = 0
		o.tabstop = 2
		o.softtabstop = 2
		o.shiftwidth = 2
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = global_group,
	callback = function()
		-- @TODO
		vim.cmd("syntax match TODO /@TODO/ containedin=@comment,@comment.documentation")
	end,
})

vim.api.nvim_create_user_command("LspVolarEnableTS", function()
	vim.g.PREVENT_CLASH_TS_VUE = "false"
	vim.cmd("LspRestart")
	vim.cmd("LspStart tsserver")
end, {})

vim.api.nvim_create_user_command("LspVolarDisableTS", function()
	vim.g.PREVENT_CLASH_TS_VUE = "true"
	vim.cmd("LspRestart")
	-- vim.cmd("LspStop tsserver")
end, {})

local split_by_space = function(s)
	local words = {}
	for word in s:gmatch("%w+") do
		table.insert(words, word)
	end
	return words
end

local utils = require("utils")
local pngpastePath = "~/dev/utils/dotfiles/pngpaste.sh"
vim.api.nvim_create_user_command("PasteImgClipboard", function(args)
	local words = split_by_space(args["args"] or "")
	local dir = words[2] or "~/dev/documents/assets/imgs"

	local now = os.date("%d.%m.%Y")
	local filename = words[1] or now

	local dest = dir .. "/" .. filename
	vim.cmd("!" .. pngpastePath .. " " .. dest)
	utils.insert("![](" .. dest .. ".png)", true)
	utils.insert(" ![[" .. filename .. ".png]]", true)
end, { nargs = "?" })

vim.api.nvim_create_user_command("Test", 'echo "It works!"', {})
