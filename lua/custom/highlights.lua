-- ~/.config/nvim/lua/custom/highlights.lua

local M = {}


M.override = {
  -- Transparent for main editor
  Normal = { bg = "NONE" },
  NormalNC = { bg = "NONE" },
  NormalFloat = { bg = "NONE" },
  FloatBorder = { bg = "NONE" },
  VertSplit = { bg = "NONE" },
  SignColumn = { bg = "NONE" },
  MsgArea = { bg = "NONE" },

  -- Transparent statusline
  StatusLine = { bg = "NONE" },
  StatusLineNC = { bg = "NONE" },

  -- Optional: transparent winbar
  WinBar = { bg = "NONE" },
  WinBarNC = { bg = "NONE" },

  -- Sidebar & float windows
  TelescopeNormal = { bg = "NONE" },
  TelescopeBorder = { bg = "NONE" },
  NvimTreeNormal = { bg = "NONE" },
  NvimTreeNormalNC = { bg = "NONE" },
  NvimTreeEndOfBuffer = { bg = "NONE" },
  NvimTreeWinSeparator = { fg = "NONE", bg = "NONE" },
}
return M
