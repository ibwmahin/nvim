require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers

local lspconfig = require "lspconfig"
local on_attach = function(client, bufnr)
  local map = vim.api.nvim_buf_set_keymap
  local opts = { noremap = true, silent = true }
  map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  map(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  map(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- Attach breadcrumbs
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
end

local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = has_cmp and cmp_nvim_lsp.default_capabilities()
  or vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {})
local servers = {
  html = {},
  cssls = {},
  ts_ls = {},
  tailwindcss = {},
  jsonls = {},
  emmet_ls = {},
  eslint = {},
  pyright = {},
  lua_ls = {
    settings = { Lua = { diagnostics = { globals = { "vim" } } } },
  },
}

require("mason").setup()
require("mason-lspconfig").setup { ensure_installed = vim.tbl_keys(servers) }

for name, cfg in pairs(servers) do
  cfg.on_attach = on_attach
  cfg.capabilities = capabilities
  lspconfig[name].setup(cfg)
end

-- Disable automatic hover when typing
vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]]

vim.cmd [[autocmd! CursorHold *]]
