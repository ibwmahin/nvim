local M = {}

M.opts = {
  ensure_installed = {
    "lua",
    "vim",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "json",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  autotag = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}

return M

