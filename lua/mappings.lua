-- ~/.config/nvim/lua/mappings.lua
-- Robust mappings for NvChad that safely guard optional plugins and avoid runtime errors.

-- Keep NvChad defaults (do this first)
pcall(function()
  require "nvchad.mappings"
end)

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Basic / Window
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Vertical Split" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Horizontal Split" })

-- Resize splits (Ctrl + Alt + h/j/k/l). Note: terminals may not send Alt reliably.
map("n", "<C-M-h>", "<cmd>vertical resize -2<CR>", { desc = "Resize split left" })
map("n", "<C-M-l>", "<cmd>vertical resize +2<CR>", { desc = "Resize split right" })
map("n", "<C-M-j>", "<cmd>resize +2<CR>", { desc = "Resize split down" })
map("n", "<C-M-k>", "<cmd>resize -2<CR>", { desc = "Resize split up" })

-- General
map("n", ";", ":", { desc = "Enter command mode" })
map("i", "jk", "<ESC>", { desc = "Escape from insert" })
map({ "n", "i", "v" }, "<C-s>", "<cmd>write<CR>", { desc = "Save file" })

-- ----------------------------
-- File explorer toggle (Ctrl+b like VS Code)
-- Works with Neo-tree if installed, otherwise falls back to NvimTree.
-- Behaves:
--  - If in a file: open and reveal the file in explorer (focus it)
--  - If in explorer: close explorer and go back to previous window
-- ----------------------------
map("n", "<C-b>", function()
  -- try neo-tree first
  local ok_neotree, neotree_cmd = pcall(require, "neo-tree.command")
  local bufname = vim.api.nvim_buf_get_name(0) or ""

  if ok_neotree and neotree_cmd then
    -- if buffer is an explorer buffer itself, toggle close and go back
    -- we avoid reveal when bufname is empty (term / no-file)
    if bufname == "" then
      neotree_cmd.execute { toggle = true, reveal_file = false }
    else
      neotree_cmd.execute { toggle = true, reveal_file = true }
    end
    return
  end

  -- fallback to nvim-tree
  local ok_nt_view, nt_view = pcall(require, "nvim-tree.view")
  local ok_nt_api, nt_api = pcall(require, "nvim-tree.api")
  if ok_nt_view and ok_nt_api and nt_view.is_visible() then
    nt_api.tree.close()
    pcall(vim.cmd, "wincmd p") -- go back to previous window
    return
  elseif ok_nt_api then
    -- if buffer has no name (terminal / empty), don't reveal
    if bufname == "" then
      nt_api.tree.toggle { focus = true, find_file = false }
    else
      nt_api.tree.toggle { focus = true, find_file = true }
    end
    return
  end

  -- if neither explorer installed, notify
  vim.notify("No file explorer found (neo-tree or nvim-tree).", vim.log.levels.WARN)
end, { desc = "Toggle file explorer (Ctrl+b)", silent = true })

-- Toggle NvimTree simple (if you still want direct mapping)
map("n", "<C-n>", function()
  if pcall(require, "nvim-tree.api") then
    vim.cmd "NvimTreeToggle"
  else
    vim.notify("nvim-tree not installed", vim.log.levels.WARN)
  end
end, { desc = "Toggle NvimTree", silent = true })

-- Telescope
map("n", "<C-p>", "<cmd>Telescope find_files hidden=true<CR>", { desc = "Telescope find files" })
map("n", "<C-f>", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" })
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })

-- Multi-cursor / visual-multi (if installed). Ctrl-d selects next occurrence
map({ "n", "v" }, "<C-d>", "<Plug>(VM-Find-Under)", { silent = true })

-- Outline (Aerial)
map("n", "<leader>o", "<cmd>AerialToggle!<CR>", { desc = "Toggle outline (Aerial)" })

-- Trouble (diagnostics)
map("n", "<leader>xx", "<cmd>TroubleToggle<CR>", { desc = "Toggle Trouble" })
map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", { desc = "Trouble workspace" })
map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", { desc = "Trouble document" })

-- LSP inline toggle (lsp_lines)
map("n", "<leader>le", function()
  local ok, lsp_lines = pcall(require, "lsp_lines")
  if not ok then
    vim.diagnostic.config { virtual_text = true }
    vim.notify("lsp_lines not installed; enabled virtual_text", vim.log.levels.INFO)
    return
  end
  if vim.g.lsp_lines_enabled then
    lsp_lines.disable()
    vim.diagnostic.config { virtual_text = true }
    vim.g.lsp_lines_enabled = false
    vim.notify("lsp_lines disabled (virtual_text ON)", vim.log.levels.INFO)
  else
    lsp_lines.setup()
    lsp_lines.enable()
    vim.diagnostic.config { virtual_text = false }
    vim.g.lsp_lines_enabled = true
    vim.notify("lsp_lines enabled (virtual_text OFF)", vim.log.levels.INFO)
  end
end, { desc = "Toggle LSP inline diagnostics" })

-- Git
map("n", "<leader>gs", "<cmd>Neogit<CR>", { desc = "Neogit" })
map("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Diffview open" })
map("n", "<leader>gD", "<cmd>DiffviewClose<CR>", { desc = "Diffview close" })
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", { desc = "Git blame line" })

-- Markdown preview
map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Markdown preview" })

-- Comments & surround (operator mappings provided by plugins)
-- gc / gcc handled by Comment plugin; ys, cs, ds by nvim-surround

-- Smart insert behaviour: when pressing 'i' in normal mode, go to 'a' if at EOL, else 'i'
-- Using expr mapping with a Lua function for clarity and safety.
map("n", "i", function()
  local col = vim.fn.col "."
  local line = vim.fn.getline "." or ""
  if col > 0 and col == #line then
    return "a"
  else
    return "i"
  end
end, { expr = true, noremap = true, desc = "Smart insert (append at eol)" })

-- Helper: neutralize conflicting short <leader>x if you prefer to avoid which-key overlap
-- This safely deletes an existing mapping for <leader>x (normal mode) to prevent which-key warnings.
pcall(function()
  vim.api.nvim_del_keymap("n", "<Space>x")
end)

-- End of mappings.lua
