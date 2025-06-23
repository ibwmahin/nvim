---@type ConformOpts
local opts = {
  formatters_by_ft = {
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    html = { "prettierd" },
    css = { "prettierd" },
    json = { "prettierd" },
    markdown = { "prettierd" },
    lua = { "stylua" },
    python = { "black" },
  },

  -- Optional: Format on save
  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true,
  },
}

return opts
