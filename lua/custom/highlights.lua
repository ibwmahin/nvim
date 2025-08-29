-- lua/chadrc.lua
---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "onedark",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },

    -- Transparent for main editor
    NormalNC = { bg = "NONE" },
    NormalFloat = { bg = "NONE" },
    FloatBorder = { bg = "NONE" },
    VertSplit = { bg = "NONE" },
    SignColumn = { bg = "NONE" },
    MsgArea = { bg = "NONE" },

    -- Optional: transparent winbar
    TelescopeNormal = { bg = "NONE" },
    TelescopeBorder = { bg = "NONE" },
    NvimTreeNormal = { bg = "NONE" },
    NvimTreeNormalNC = { bg = "NONE" },
    NvimTreeEndOfBuffer = { bg = "NONE" },
    NvimTreeWinSeparator = { fg = "NONE", bg = "NONE" },
    -- Make editor background and top/tab/status/bufferline transparent
    Normal = { bg = "NONE" },

    -- built-in Vim tabline groups
    TabLine = { bg = "NONE" },
    TabLineSel = { bg = "NONE" },
    TabLineFill = { bg = "NONE" },

    -- statusline / winbar
    StatusLine = { bg = "NONE" },
    StatusLineNC = { bg = "NONE" },

    -- Opitonal: transparent winbar
    WinBar = { bg = "NONE" },
    WinBarNC = { bg = "NONE" },

    -- bufferline groups (bufferline.nvim / NvChad tabufline)
    BufferLineFill = { bg = "NONE" },
    BufferLineBackground = { bg = "NONE" },
    BufferLineSeparator = { bg = "NONE" },
    BufferLineIndicatorSelected = { bg = "NONE" },
    BufferLineIndicatorVisible = { bg = "NONE" },
    BufferLineGap = { bg = "NONE" },

    -- nvchad tabufline specific attempt (some themes use custom groups)
    Tabufline = { bg = "NONE" },
    TabuflineFill = { bg = "NONE" },
    TabuflineSel = { bg = "NONE" },
  },
}

M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    lazyload = false,
  },
}

return M
