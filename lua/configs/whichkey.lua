require("which-key").setup {
  plugins = {
    spelling = { enabled = true, suggestions = 20 },
  },
  window = {
    border = "rounded",
  },
  icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "+",
  },
  layout = {
    spacing = 6,
  },
}
