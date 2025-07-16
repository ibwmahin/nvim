require("ibl").setup {
  indent = {
    char = "│", -- You can change this to "▏" or "▎" or "╎"
    tab_char = "│",
  },
  scope = {
    enabled = true,
    highlight = { "IndentBlanklineScopeChar" }, -- uses custom highlight
    show_start = false,
    show_end = false,
  },
  whitespace = {
    remove_blankline_trail = true,
  },
  exclude = {
    filetypes = {
      "help",
      "dashboard",
      "lazy",
      "notify",
      "TelescopePrompt",
      "neo-tree",
      "NvimTree",
      "",
    },
  },
}
