-- ~/.config/nvim/lua/custom/highlights.lua

local M = {}

M.override = {
  -- Transparent for main editor
  Normal = { bg = "NONE" },
  -- NormalNC = { bg = "NONE" },
  -- NormalFloat = { bg = "NONE" },
  -- FloatBorder = { bg = "NONE" },
  -- VertSplit = { bg = "NONE" },
  -- SignColumn = { bg = "NONE" },
  -- MsgArea = { bg = "NONE" },

  -- Solid background for NvimTree

  -- side bar --------------------------
  -- TelescopeNormal = { bg = "NONE" },
  -- TelescopeBorder = { bg = "NONE" },
  -- NvimTreeNormal = { bg = "NONE" },
  -- NvimTreeNormalNC = { bg = "NONE" },
  -- NvimTreeEndOfBuffer = { bg = "NONE" },
  -- NvimTreeWinSeparator = { fg = "NONE", bg = "NONE" },

  -- Solid background for NvimTree
  -- NvimTreeNormal = { bg = "#1e1e2e" },
  -- NvimTreeNormalNC = { bg = "#1e1e2e" },
  -- NvimTreeEndOfBuffer = { bg = "#1e1e2e" },
  -- NvimTreeWinSeparator = { fg = "#1e1e2e", bg = "#1e1e2e" },
}

return M
