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
end

-- Treesitter setup (without autotag here)
require("nvim-treesitter.configs").setup {
  ensure_installed = { "lua", "html", "css", "javascript", "typescript", "tsx" },
  highlight = { enable = true },
}

-- Setup nvim-ts-autotag separately (already done in plugins, but good to call here as well)
require("nvim-ts-autotag").setup()

-- Mason setup
require("mason").setup()

-- Mason-lspconfig setup: automatically install listed servers
require("mason-lspconfig").setup {
  ensure_installed = {
    "ts_ls", -- TypeScript/JavaScript LSP
    "html",
    "cssls",
    "jsonls",
    "lua_ls",
    "emmet_ls",
    "tailwindcss",
  },
}

-- Import lspconfig
local lspconfig = require "lspconfig"

-- LSP server configurations
local servers = {
  ts_ls = {}, -- TypeScript + JavaScript
  html = {},
  cssls = {},
  jsonls = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" }, -- To avoid "vim is undefined" warnings
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true), -- Make the server aware of Neovim runtime files
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
}

-- Attach on_attach and capabilities to each server and setup
local capabilities = require("cmp_nvim_lsp").default_capabilities()

for server_name, config in pairs(servers) do
  config.on_attach = on_attach
  config.capabilities = capabilities
  lspconfig[server_name].setup(config)
end
