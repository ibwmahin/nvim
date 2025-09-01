-- ~/.config/nvim/lua/mappings.lua
-- Robust mappings for NvChad that safely guard optional plugins and avoid runtime errors.
-- Includes a persistent fix to ensure ';' enters command-line (colon) even if something
-- else later tries to override it.

-- Keep NvChad defaults (do this first). Use pcall so missing module won't error.
pcall(function()
  require "nvchad.mappings"
end)

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ===================================================================
-- Persistent semicolon->colon mapping:
-- Ensure ';' opens the command line and re-apply it on common events
-- in case a plugin or later file rebinds the key.
-- ===================================================================

local function ensure_semicolon_mapping()
  -- remove any existing normal-mode mapping for ';' (safe even if none exists)
  pcall(vim.api.nvim_del_keymap, "n", ";")
  -- set the reliable mapping
  vim.keymap.set("n", ";", ":", { noremap = true, desc = "Enter command mode" })
end

-- apply immediately
ensure_semicolon_mapping()

-- re-apply on events that often run after mappings are loaded
local semigroup = vim.api.nvim_create_augroup("EnsureSemicolonMap", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "BufWinEnter", "ColorScheme" }, {
  group = semigroup,
  callback = function()
    -- small schedule to let other autocommands run first
    vim.schedule(function()
      ensure_semicolon_mapping()
    end)
  end,
})

-- ===================================================================
-- Basic / Window mappings
-- ===================================================================

map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Vertical Split" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Horizontal Split" })

-- Resize splits (Ctrl + Alt + h/j/k/l). Note: terminals may not send Alt reliably.
map("n", "<C-M-h>", "<cmd>vertical resize -2<CR>", { desc = "Resize split left" })
map("n", "<C-M-l>", "<cmd>vertical resize +2<CR>", { desc = "Resize split right" })
map("n", "<C-M-j>", "<cmd>resize +2<CR>", { desc = "Resize split down" })
map("n", "<C-M-k>", "<cmd>resize -2<CR>", { desc = "Resize split up" })

-- General
map("i", "jk", "<ESC>", { desc = "Escape from insert" })
map({ "n", "i", "v" }, "<C-s>", "<cmd>write<CR>", { desc = "Save file" })

-- ===================================================================
-- File explorer toggle (Ctrl+b like VS Code)
-- Works with Neo-tree if installed, otherwise falls back to NvimTree.
-- ===================================================================

map("n", "<C-b>", function()
  local ok_neotree, neotree_cmd = pcall(require, "neo-tree.command")
  local bufname = vim.api.nvim_buf_get_name(0) or ""

  if ok_neotree and neotree_cmd then
    if bufname == "" then
      neotree_cmd.execute { toggle = true, reveal_file = false }
    else
      neotree_cmd.execute { toggle = true, reveal_file = true }
    end
    return
  end

  local ok_nt_view, nt_view = pcall(require, "nvim-tree.view")
  local ok_nt_api, nt_api = pcall(require, "nvim-tree.api")
  if ok_nt_view and ok_nt_api and nt_view.is_visible() then
    nt_api.tree.close()
    pcall(vim.cmd, "wincmd p")
    return
  elseif ok_nt_api then
    if bufname == "" then
      nt_api.tree.toggle { focus = true, find_file = false }
    else
      nt_api.tree.toggle { focus = true, find_file = true }
    end
    return
  end

  vim.notify("No file explorer found (neo-tree or nvim-tree).", vim.log.levels.WARN)
end, { desc = "Toggle file explorer (Ctrl+b)", silent = true })

vim.keymap.del("n", "<C-n>")
map("n", "<C-n>", "<cmd>Neotree toggle<cr>", { desc = "Explorer (Neo-tree)" })

-- ===================================================================
-- Telescope
-- ===================================================================

map("n", "<C-p>", "<cmd>Telescope find_files hidden=true<CR>", { desc = "Telescope find files", silent = true })
map("n", "<C-f>", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep", silent = true })
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })

-- (rest of your mappings unchanged)
-- ===================================================================
-- End of mappings.lua
