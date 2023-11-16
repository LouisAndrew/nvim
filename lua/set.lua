local opt = vim.opt;
opt.nu = true
opt.relativenumber = true

-- indents etc
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.wrap = false

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

opt.iskeyword:append("-")
