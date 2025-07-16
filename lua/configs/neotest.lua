
require("neotest").setup({
  adapters = {
    require("neotest-jest")({
      jestCommand = "npm test --",
      env = { CI = true },
      cwd = vim.fn.getcwd,
    }),
  },
})
