---@type ChadrcConfig
local M = {}

M.options = {
  relativenumber = true,
  number = true,
}

M.base46 = {
  theme = "kanagawa",
  transparency = true,
  -- hl_override = {
  --   -- Base transparent highlight groups
  --   Normal = { bg = "NONE" },
  --   NormalNC = { bg = "NONE" },
  --   NormalFloat = { bg = "NONE" },
  --   FloatBorder = { bg = "NONE" },
  --   VertSplit = { bg = "NONE" },
  --   SignColumn = { bg = "NONE" },
  --   MsgArea = { bg = "NONE" },
  --
  --   -- Statusline and tabline transparency
  --   StatusLine = { bg = "NONE" },
  --   StatusLineNC = { bg = "NONE" },
  --   TabLine = { bg = "NONE" },
  --   TabLineSel = { bg = "NONE" },
  --   TabLineFill = { bg = "NONE" },
  --   BufferLineBackground = { bg = "NONE" },
  --   BufferLineFill = { bg = "NONE" },
  --
  --   -- Other transparent groups
  --   TelescopeNormal = { bg = "NONE" },
  --   TelescopeBorder = { bg = "NONE" },
  --   NvimTreeNormal = { bg = "NONE" },
  --   NvimTreeNormalNC = { bg = "NONE" },
  --   NvimTreeEndOfBuffer = { bg = "NONE" },
  --   NvimTreeWinSeparator = { fg = "NONE", bg = "NONE" },
  --   WinBar = { bg = "NONE" },
  --   WinBarNC = { bg = "NONE" },
  -- },
}

M.plugins = "plugins"

return M
