---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "solarized_dark",
  transparency = true, -- this disables solid bg override
  hl_override = require("custom.highlights").override,
  hl_override = {
  	Comment = { italic = true },
  	["@comment"] = { italic = true },
  },
}
M.plugins = "plugins" -- loads lua/plugins/init.lua

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
--}

return M
