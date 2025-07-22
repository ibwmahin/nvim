local lspconfig = require "lspconfig"
local mason = require "mason"
local mason_lspconfig = require "mason-lspconfig"
local cmp_nvim_lsp = require "cmp_nvim_lsp"

-- Setup mason
mason.setup()

-- List of LSP servers to install
local servers = {
  "ts_ls", -- ✅ Correct LSP name (was "ts_ls" before, fixed)
  "vtsls", -- optional, advanced TS support
  "html",
  "cssls",
  "jsonls",
  "lua_ls",
  "tailwindcss",
  "eslint",
  "emmet_ls",
}

-- Capabilities for nvim-cmp
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Setup mason-lspconfig
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

-- Setup handlers for LSPs
if mason_lspconfig.setup_handlers then
  mason_lspconfig.setup_handlers {
    -- Default handler
    function(server_name)
      lspconfig[server_name].setup {
        capabilities = capabilities,
      }
    end,

    -- Lua: Neovim config, runtime globals
    ["lua_ls"] = function()
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      }
    end,

    -- TypeScript: Auto-import, file operations, etc.
    ["tsserver"] = function()
      require("typescript").setup {
        server = {
          capabilities = capabilities,
        },
      }
    end,

    -- ✅ Emmet for HTML, JSX, CSS
    ["emmet_ls"] = function()
      lspconfig.emmet_ls.setup {
        capabilities = capabilities,
        filetypes = {
          "html",
          "css",
          "scss",
          "sass",
          "javascript",
          "javascriptreact",
          "typescriptreact",
          "vue",
          "svelte",
        },
        init_options = {
          html = {
            options = {
              ["bem.enabled"] = true,
            },
          },
        },
      }
    end,
    -- ✅ TailwindCSS: Autocomplete for JSX, HTML, className, etc.
    ["tailwindcss"] = function()
      lspconfig.tailwindcss.setup {
        capabilities = capabilities,
        filetypes = {
          "html",
          "css",
          "scss",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "svelte",
          "astro",
          "templ",
        },
        init_options = {
          userLanguages = {
            eelixir = "html",
            eruby = "html",
            heex = "html",
            javascript = "javascript",
            javascriptreact = "javascript",
            typescript = "typescript",
            typescriptreact = "typescript",
            vue = "vue",
            svelte = "svelte",
          },
        },
        settings = {
          tailwindCSS = {
            lint = {
              cssConflict = "warning",
              invalidApply = "error",
              invalidConfigPath = "error",
              invalidScreen = "error",
              invalidTailwindDirective = "error",
              invalidVariant = "error",
              recommendedVariantOrder = "warning",
            },
            experimental = {
              classRegex = {
                'class\\s*=\\s*"([^"]*)"',
                'className\\s*=\\s*"([^"]*)"',
                "tw`([^`]*)",
                'tw\\("([^"]*)',
                "tw\\('([^']*)",
                "classnames\\(([^)]*)\\)",
                "clsx\\(([^)]*)\\)",
                "cx\\(([^)]*)\\)",
              },
            },
            validate = true,
          },
        },
      }
    end,
  }
else
  -- Fallback if setup_handlers not available
  for _, server in ipairs(servers) do
    if server == "lua_ls" then
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      }
    elseif server == "tsserver" then
      require("typescript").setup {
        server = {
          capabilities = capabilities,
        },
      }
    elseif server == "tailwindcss" then
      lspconfig.tailwindcss.setup {
        capabilities = capabilities,
        filetypes = {
          "html",
          "css",
          "scss",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "svelte",
          "astro",
          "templ",
        },
        init_options = {
          userLanguages = {
            eelixir = "html",
            eruby = "html",
            heex = "html",
            javascript = "javascript",
            javascriptreact = "javascript",
            typescript = "typescript",
            typescriptreact = "typescript",
            vue = "vue",
            svelte = "svelte",
          },
        },
        settings = {
          tailwindCSS = {
            lint = {
              cssConflict = "warning",
              invalidApply = "error",
              invalidConfigPath = "error",
              invalidScreen = "error",
              invalidTailwindDirective = "error",
              invalidVariant = "error",
              recommendedVariantOrder = "warning",
            },
            experimental = {
              classRegex = {
                'class\\s*=\\s*"([^"]*)"',
                'className\\s*=\\s*"([^"]*)"',
                "tw`([^`]*)",
                'tw\\("([^"]*)',
                "tw\\('([^']*)",
                "classnames\\(([^)]*)\\)",
                "clsx\\(([^)]*)\\)",
                "cx\\(([^)]*)\\)",
              },
            },
            validate = true,
          },
        },
      }
    else
      lspconfig[server].setup {
        capabilities = capabilities,
      }
    end
  end
end
