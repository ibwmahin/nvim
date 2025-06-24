-- LSP keymaps setup function
local on_attach = function(client, bufnr)
  local bufmap = function(mode, lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
  end

  bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  bufmap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  bufmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
  bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")

  -- ✅ Add nvim-navic breadcrumb support
  local navic_ok, navic = pcall(require, "nvim-navic")
  if navic_ok and client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

-- Treesitter setup (without autotag here)
-- require("nvim-treesitter.configs").setup {
--   ensure_installed = { "lua", "html", "css", "javascript", "typescript", "tsx" },
--   highlight = { enable = true },
-- }
--
-- Setup nvim-ts-autotag separately
require("nvim-ts-autotag").setup()

-- Mason setup
require("mason").setup()

-- Mason-lspconfig setup
require("mason-lspconfig").setup {
  ensure_installed = {
    "ts_ls", -- TypeScript/JavaScript
    "html",
    "cssls",
    "jsonls",
    "lua_ls",
    "emmet_ls",
    "tailwindcss",
    "pyright", -- ✅ Python
    "eslint", -- ✅ Linting for Next.js
  },
}

-- Import lspconfig
local lspconfig = require "lspconfig"

-- LSP server configurations
local servers = {
  ts_ls = {}, -- TypeScript + JavaScript (kept untouched)
  html = {},
  cssls = {},
  jsonls = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  emmet_ls = {
    filetypes = {
      "html",
      "typescriptreact",
      "javascriptreact",
      "javascript",
      "typescript",
      "css",
      "sass",
      "scss",
      "less",
      "svelte",
    },
  },
  tailwindcss = {},

  -- ✅ Python Support
  pyright = {
    filetypes = { "python" },
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
        },
      },
    },
  },

  -- ✅ ESLint for Next.js
  eslint = {
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
  },
}

-- Attach on_attach and capabilities to each server
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.ts_ls.setup {
  capabilities = capabilities,
}
for server_name, config in pairs(servers) do
  config.on_attach = on_attach
  config.capabilities = capabilities
  lspconfig[server_name].setup(config)
end

-- ✅ Optional: Show breadcrumb in the winbar
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
