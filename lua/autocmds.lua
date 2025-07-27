require "nvchad.autocmds"

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.opt.relativenumber = false
    vim.opt.number = true
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.opt.relativenumber = true
    vim.opt.number = true
  end,
})

-- Force it ON at startup
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.relativenumber = true
    vim.opt.number = true
  end,
})
