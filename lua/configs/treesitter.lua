
return {
  ensure_installed = {
    "bash","c","cpp","css","html","javascript","json","lua",
    "markdown","python","typescript","tsx","vim","yaml"
  },
  highlight = { enable = true },
  indent    = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = "<C-s>",
      node_decremental = "<M-space>",
    },
  },
}
