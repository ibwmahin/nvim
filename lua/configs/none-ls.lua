
local none_ls = require("none-ls")

none_ls.setup({
  sources = {
    none_ls.builtins.formatting.prettier,
    none_ls.builtins.formatting.stylua,
    none_ls.builtins.diagnostics.eslint,
  },
})
