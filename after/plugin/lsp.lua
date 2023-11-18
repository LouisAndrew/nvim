local lsp_zero = require("lsp-zero")
local ft = require("guard.filetype")
local lspkind = require("lspkind")
local saga = require("lspsaga")

lsp_zero.on_attach(function(_, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "<leader>iO", function()
    vim.lsp.buf.definition()
  end, opts)

  vim.keymap.set("n", "<leader>ii", "<cmd>Lspsaga hover_doc<CR>", opts)

  vim.keymap.set("n", "<leader>io", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window

  vim.keymap.set("n", "<leader>if", "<cmd>Lspsaga lsp_finder<CR>", opts)     -- show definition, references
  vim.keymap.set("n", "<leader>is", function()
    vim.lsp.buf.workspace_symbol()
  end, opts)

  vim.keymap.set("n", "<leader>id", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
  vim.keymap.set("n", "<leader>iD", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
  vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
  vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
  vim.keymap.set("n", "<leader>ia", "<cmd>Lspsaga code_action<CR>", opts)
  vim.keymap.set("n", "<leader>ir", "<cmd>Telescope lsp_references<cr>", opts)
  vim.keymap.set("n", "<leader>in", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
  vim.keymap.set("n", "<leader>rr", "<cmd>LspRestart<CR>", opts)    -- smart rename

  vim.keymap.set("n", "<leader>ie", function()
    vim.lsp.util.show_line_diagnostics()
  end, opts)

  vim.keymap.set("i", "<C-u>", function()
    vim.lsp.buf.signature_help()
  end, opts)

  vim.keymap.set({ "n", "i" }, "<C-s>", function()
    vim.lsp.buf.format({ async = true })
  end, opts)

  -- make sure it works
  vim.keymap.set("i", "<C-h>", "<Left>", opts)
end)

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = { "tsserver", "rust_analyzer", "eslint", "volar", "tailwindcss", "cssls", "html" },
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require("lspconfig").lua_ls.setup(lua_opts)
    end,
  },
})

require("lspconfig").graphql.setup({
  filetypes = { "graphql", "javascript", "typescript", "typescriptreact" },
})

saga.setup({
  -- keybinds for navigation in lspsaga window
  scroll_preview = { scroll_down = "<C-d>", scroll_up = "<C-u>" },
  definition = {
    keys = {
      edit = "<C-c>i",
      vsplit = "<C-c>l",
      split = "<C-c>j",
      quit = "<leader>w",
    },
  },
  ui = {
    colors = {
      normal_bg = "#022746",
    },
  },
  symbol_in_winbar = {
    separator = " x ",
  },
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "luasnip" },
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol",    -- show only symbol annotations
      maxwidth = 50,      -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item)
        return vim_item
      end,
    }),
  },
  -- formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-e>"] = cmp.mapping.complete(),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
  }),
})

ft("typescript,javascript,typescriptreact"):fmt("eslint_d")
ft("vue"):fmt("eslint_d")
ft("lua"):fmt("lsp"):append("stylua")

require("guard").setup({
  fmt_on_save = true,
  lsp_as_default_formatter = true,
})
