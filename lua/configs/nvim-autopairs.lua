-- File: lua/configs/nvim-autopairs.lua
local npairs = require "nvim-autopairs"
local Rule = require "nvim-autopairs.rule"

npairs.setup {
  check_ts = true,
  fast_wrap = {},
  disable_filetype = { "TelescopePrompt", "vim" },
  map_cr = true,
}

-- Integrate with nvim-cmp
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp = require "cmp"
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
