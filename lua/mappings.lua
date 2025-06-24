-- ~/.config/nvim/lua/mappings.lua

require "nvchad.mappings"

local map = vim.keymap.set

-- Open vertical split
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical Split" })

-- Open horizontal split
map("n", "<leader>sh", ":split<CR>", { desc = "Horizontal Split" })
-- Resize splits with Ctrl + Alt + H/J/K/L
map("n", "<C-M-h>", ":vertical resize -2<CR>", { desc = "Resize split left" })
map("n", "<C-M-l>", ":vertical resize +2<CR>", { desc = "Resize split right" })
map("n", "<C-M-j>", ":resize +2<CR>", { desc = "Resize split down" })
map("n", "<C-M-k>", ":resize -2<CR>", { desc = "Resize split up" })

-- General mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Toggle NvimTree
map("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Toggle File Tree" })

-- Telescope mappings
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find Files" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live Grep" })

-- Smart insert mode fix: i goes to end if at last character
vim.api.nvim_set_keymap("n", "i", [[v:lua.smart_insert_mode()]], { expr = true, noremap = true })
function _G.smart_insert_mode()
  local col = vim.fn.col "."
  local line = vim.fn.getline "."
  if col > 0 and col == #line then
    return "a"
  else
    return "i"
  end
end
