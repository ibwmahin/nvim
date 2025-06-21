require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Include default NvChad maps
require "nvchad.mappings"
local map = vim.keymap.set

-- Splits
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical Split" })
map("n", "<leader>sh", ":split<CR>", { desc = "Horizontal Split" })

-- Resize
map("n", "<C-M-h>", ":vertical resize -2<CR>")
map("n", "<C-M-l>", ":vertical resize +2<CR>")
map("n", "<C-M-j>", ":resize +2<CR>")
map("n", "<C-M-k>", ":resize -2<CR>")

-- File explorer
map("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Toggle Explorer" })

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>")
map("n", "<leader>fg", ":Telescope live_grep<CR>")

-- Git
map("n", "<leader>gs", ":Gitsigns stage_hunk<CR>")
map("n", "<leader>gr", ":Gitsigns reset_hunk<CR>")

-- Format & Lint
map("n", "<leader>cf", ":LazyFormat<CR>", { desc = "Format Buffer" })

-- Trouble
map("n", "<leader>xx", ":TroubleToggle<CR>")

-- Smart insert
vim.api.nvim_set_keymap("n", "i", [[v:lua.smart_insert_mode()]], { expr = true, noremap = true })
function _G.smart_insert_mode()
  local col = vim.fn.col "."
  local line = vim.fn.getline "."
  return (col > 0 and col == #line) and "a" or "i"
end
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
