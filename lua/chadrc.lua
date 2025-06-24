---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tokyodark",
  -- hl_override = require("custom.highlights").override,
  -- hl_override = {
  --   Comment = { italic = true },
  --   ["@comment"] = { italic = true },
  -- },
}
M.plugins = "plugins" -- loads lua/plugins/init.lua

return M
