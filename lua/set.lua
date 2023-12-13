local opt = vim.opt
opt.nu = true
opt.relativenumber = true

-- indents etc
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.wrap = false
opt.laststatus = 3

opt.smartindent = true
opt.foldcolumn = "1"

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

vim.keymap.set("n", "<leader>bd", function()
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
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = global_group,
	callback = function()
		-- @TODO
		vim.cmd("syntax match TODO /@TODO/")
	end,
})
