-- n, v, i, t = mode names

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
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
  },

  n = {
    ["<ESC>"] = { "<cmd> noh <CR>", "no highlight" },

    -- Customs
    ["<S-j>"] = { "}", "skip bracket" },
    ["<S-k>"] = { "{", "skip bracket up" },
    ["<S-h>"] = { "^", "start of line" },
    ["<S-l>"] = { "$", "end of line" },
    ["'"] = { "*", "next occurence" },
    [";"] = { "#", "last occurence" },
    ["<C-u>"] = { "<C-d>zz", "scroll page down" },
    ["<C-d>"] = { "<C-u>zz", "scroll page up" },
    
    ["<A-k>"] = { "O", "move line up" },

    ["˚"] = { "<cmd> :m-2 <CR>", "line up" },
    ["∆"] = { "<cmd> :m+ <CR>", "line down" },
    ["gh"] = { "<Plug>VSCodeCommentaryLine" },
    
    ["¬"] = { ":call VSCodeNotify('workbench.action.splitEditorRight') <CR>" },
    ["˙"] = { ":call VSCodeNotify('workbench.action.splitEditorLeft') <CR>" },
    ["<leader>l"] = { ":call VSCodeNotify('workbench.action.focusNextGroup') <CR>" },
    ["<leader>h"] = { ":call VSCodeNotify('workbench.action.focusPreviousGroup') <CR>" },


    ["<C-l>"] = { ":call VSCodeNotify('editor.action.jumpToBracket') <CR>" },
    
    -- save
    ["<C-s>"] = { "<cmd> w <CR>", "save file" },

    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "copy whole file" },

    -- line numbers
    ["<leader>n"] = { "<cmd> set nu! <CR>", "toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "toggle relative number" },

    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["<leader>b"] = { "<cmd> enew <CR>", "new buffer" },
  },

  t = { ["<C-x>"] = { termcodes "<C-\\><C-N>", "escape terminal " } },

  v = {
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["<S-j>"] = { "}", "skip bracket" },
    ["<S-k>"] = { "{", "skip bracket up" },
    ["<S-h>"] = { "^", "start of line" },
    ["<S-l>"] = { "$", "end of line" },
    ["n"] = { "*", "next occurence" },
    ["N"] = { "#", "last occurence" },
    ["i"] = { "s" },
    ["gh"] = { "<Plug>VSCodeCommentary" },
  },

  x = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
  },
}

vim.g.mapleader = " "
for mode, t in pairs(M) do
  for key, remap in pairs(t) do
    vim.keymap.set(mode, key, remap[1], remap.opts)
  end
end
